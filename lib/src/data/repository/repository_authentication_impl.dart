import 'dart:async';
import 'dart:io';

import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:strava_client/src/common/common.dart';
import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository_authentication.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RepositoryAuthenticationImpl extends RepositoryAuthentication {
  ///Used for nativa Starva app callback
  StreamSubscription<Uri?>? _uriLinkStream;

  @override
  Future<TokenResponse> authenticate(
      {required List<AuthenticationScope> scopes,
      required String redirectUrl,
      required String callbackUrlScheme,
      bool forceShowingApproval = false,
      bool? preferEphemeral}) async {
    var completer = Completer<TokenResponse>();
    var token = await sl<SessionManager>().getToken();
    if (token == null) {
      completer.complete(_completeAuthentication(
          scopes: scopes,
          forceShowingApproval: forceShowingApproval,
          redirectUrl: redirectUrl,
          callbackUrlScheme: callbackUrlScheme,
          preferEphemeral: preferEphemeral));
    } else {
      List<AuthenticationScope> oldScopes =
          AuthenticationScopeHelper.generateScopes(token.scopes ?? "");
      var isScopesAreSame = _compareScopes(oldScopes, scopes);
      if (isScopesAreSame) {
        if (sl<SessionManager>().isTokenExpired(token)) {
          _refreshAccessToken(sl<SessionManager>().clientId,
                  sl<SessionManager>().secret, token.refreshToken)
              .then((refreshResult) {
            sl<SessionManager>()
                .setToken(
                    scopes: scopes,
                    token: TokenResponse(
                        tokenType: token.tokenType,
                        expiresAt: refreshResult.expiresAt,
                        expiresIn: refreshResult.expiresIn,
                        refreshToken: refreshResult.refreshToken,
                        accessToken: refreshResult.accessToken))
                .then((value) => completer.complete(refreshResult));
          }).onError((error, stackTrace) {
            completer.completeError(error!, stackTrace);
          });
        } else {
          completer.complete(token);
        }
      } else {
        // Scopes have changed. we need a new token.
        completer.complete(_completeAuthentication(
            scopes: scopes,
            forceShowingApproval: forceShowingApproval,
            redirectUrl: redirectUrl,
            callbackUrlScheme: callbackUrlScheme,
            preferEphemeral: preferEphemeral));
      }
    }
    return completer.future;
  }

  Future<TokenResponse> _completeAuthentication(
      {required List<AuthenticationScope> scopes,
      required bool forceShowingApproval,
      required String redirectUrl,
      required String callbackUrlScheme,
      bool? preferEphemeral}) {
    return _getStravaCode(
            redirectUrl: redirectUrl,
            scopes: scopes,
            forceShowingApproval: forceShowingApproval,
            callbackUrlScheme: callbackUrlScheme,
            preferEphemeral: preferEphemeral)
        .then((code) {
      return _requestNewAccessToken(
              sl<SessionManager>().clientId, sl<SessionManager>().secret, code)
          .then((token) async {
        await sl<SessionManager>().setToken(token: token, scopes: scopes);
        return token;
      });
    });
  }

  /// RedirectUrl works best when it is a custom scheme. For example: strava://auth
  ///
  /// If your redirectUrl is, for example, strava://auth then your callbackUrlScheme should be strava
  Future<String> _getStravaCode(
      {required String redirectUrl,
      required List<AuthenticationScope> scopes,
      required bool forceShowingApproval,
      required String callbackUrlScheme,
      bool? preferEphemeral}) async {
    final Completer<String> completer = Completer<String>();
    final params =
        '?client_id=${sl<SessionManager>().clientId}&redirect_uri=$redirectUrl&response_type=code&approval_prompt=${forceShowingApproval ? "force" : "auto"}&scope=${AuthenticationScopeHelper.buildScopeString(scopes)}';
    final _appLinks = AppLinks();

    var host = "https://www.strava.com/";

    const authorizationEndpoint = "oauth/mobile/authorize";

    var didLaunchNativeApp = false;
    if (Platform.isIOS) {
      //We need to check if we have the strava app in the phone, if yes we will launch the app
      if (await canLaunchUrlString("strava://$authorizationEndpoint")) {
        didLaunchNativeApp = true;
        host = "strava://";
        _uriLinkStream?.cancel();
        _uriLinkStream = _appLinks.uriLinkStream.listen((uri) {
          final error = uri.queryParameters['error'];
          final code = uri.queryParameters['code'];
          if (error != null) {
            completer.completeError(Fault(errors: [], message: error));
          } else {
            completer.complete(code);
          }
          _uriLinkStream?.cancel();
        });
        launchUrlString(host + authorizationEndpoint + params).then((value) {});
      }
    }
    if (!didLaunchNativeApp) {
      final reqAuth = host + authorizationEndpoint + params;
      try {
        final result = await FlutterWebAuth2.authenticate(
            url: reqAuth,
            callbackUrlScheme: callbackUrlScheme,
            options: FlutterWebAuth2Options(preferEphemeral: preferEphemeral));

        final parsed = Uri.parse(result);

        final error = parsed.queryParameters['error'];
        final code = parsed.queryParameters['code'];
        if (error != null) {
          completer.completeError(Fault(errors: [], message: error));
        } else {
          completer.complete(code);
        }
      } catch (e) {
        completer.completeError(Fault(errors: [], message: e.toString()));
      }
    }
    return completer.future;
  }

  Future<TokenResponse> _requestNewAccessToken(
      String clientID, String secret, String code) {
    return ApiClient.postRequest(
        endPoint: "/v3/oauth/token",
        queryParameters: {
          "client_id": clientID,
          "client_secret": secret,
          "code": code,
          "grant_type": "authorization_code",
        },
        dataConstructor: (data) => TokenResponse.fromJson(data));
  }

  Future<TokenResponse> _refreshAccessToken(
      String clientID, String secret, String refreshToken) {
    return ApiClient.postRequest<TokenResponse>(
        endPoint: "/v3/oauth/token",
        queryParameters: {
          "client_id": clientID,
          "client_secret": secret,
          "grant_type": "refresh_token",
          "refresh_token": refreshToken
        },
        dataConstructor: (data) => TokenResponse.fromJson(data));
  }

  bool _compareScopes(
      List<AuthenticationScope> left, List<AuthenticationScope> right) {
    if (left.length != right.length) {
      return false;
    }
    return left.every((element) => right.contains(element));
  }

  @override
  Future<void> deAuthorize() async {
    var token = await sl<SessionManager>().getToken();

    var params = {"access_token": token?.accessToken ?? ""};
    return ApiClient.postRequest(
            baseUrl: "https://www.strava.com/",
            endPoint: "/oauth/deauthorize",
            queryParameters: params,
            dataConstructor: (data) => null)
        .whenComplete(() => sl<SessionManager>().logout());
  }
}
