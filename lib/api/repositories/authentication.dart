import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:strava_flutter/api/client.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/models/refresh_token.dart';
import 'package:strava_flutter/models/strava_auth_scopes.dart';
import 'package:strava_flutter/models/strava_fault.dart';
import 'package:strava_flutter/models/token.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class StravaAuthentication{
  Future<void> authenticate({
    required List<StravaAuthScope> scopes,
    required bool forceShowingApproval,
    required String redirectUrl
  }) async{
    var completer = Completer();
    var token = await SessionManager.getInstance.getToken();
    if (token == null) {
      completer.complete(_completeAuthentication(scopes: scopes, forceShowingApproval: forceShowingApproval, redirectUrl: redirectUrl));
    }else{
      List<StravaAuthScope> oldScopes = StravaAuthScopeHelper.generateScopes(token.scopes ?? "");
      var isScopesAreSame = _compareScopes(oldScopes, scopes);
      if(isScopesAreSame){
        if(SessionManager.getInstance.isTokenExpired(token)){
          return _refreshAccessToken(SessionManager.getInstance.clientId,SessionManager.getInstance.secret,token.refreshToken)
              .then((refreshResult)=>SessionManager.getInstance.setToken(
              scopes: scopes,
              token: Token(
                  tokenType: token.tokenType,
                  expiresAt: refreshResult.expiresAt,
                  expiresIn: refreshResult.expiresIn,
                  refreshToken: refreshResult.refreshToken,
                  accessToken: refreshResult.accessToken)
          ));
        }else{
          completer.complete(_completeAuthentication(scopes: scopes, forceShowingApproval: forceShowingApproval, redirectUrl: redirectUrl));
        }
      }else{
        ///Scopes have changed. we need a new token.
        completer.complete(_completeAuthentication(scopes: scopes, forceShowingApproval: forceShowingApproval, redirectUrl: redirectUrl));
      }
    }
    return completer.future;
  }

  Future<void> _completeAuthentication({
    required List<StravaAuthScope> scopes,
    required bool forceShowingApproval,
    required String redirectUrl
  }){
    return _getStravaCode(redirectUrl: redirectUrl, scopes: scopes, forceShowingApproval: forceShowingApproval)
        .then((code){
        return _requestNewAccessToken(SessionManager.getInstance.clientId, SessionManager.getInstance.secret, code)
            .then((token){
             return SessionManager.getInstance.setToken(token: token, scopes: scopes);
        });
    });
  }

  Future<String> _getStravaCode(
      { required String redirectUrl,
        required List<StravaAuthScope> scopes,
        required bool forceShowingApproval}){
    final Completer<String> completer = Completer<String>();
    final params =
        '?client_id=${SessionManager.getInstance.clientId}&redirect_uri=$redirectUrl&response_type=code&approval_prompt=${forceShowingApproval ? "force" : "auto"}&scope=${StravaAuthScopeHelper.buildScopeString(scopes)}';
    var authorizationEndpoint = "https://www.strava.com/oauth/mobile/authorize";
    final reqAuth = authorizationEndpoint + params;
    
    launch(reqAuth,
        forceWebView: false,
        forceSafariVC: false,
        enableJavaScript: true);
    late final StreamSubscription linkStreamSubscription;
    linkStreamSubscription = uriLinkStream.listen((uri) {
      var error = uri?.queryParameters["error"];
      var code = uri?.queryParameters["code"];
      if(error != null){
        completer.completeError(StravaFault(errors: [],message: error));
      }else{
        completer.complete(code);
      }
      linkStreamSubscription.cancel();
    });
    return completer.future;
  }
  
  Future<Token> _requestNewAccessToken(String clientID,
      String secret,
      String code){
    return ApiClient.postRequest(
        endPoint: "/v3/oauth/token",
        queryParameters: {
          "client_id":clientID,
          "client_secret":secret,
          "code":code,
          "grant_type":"authorization_code",
        },
        dataConstructor: (data)=>Token.fromJson(data));
  }

  Future<RefreshToken> _refreshAccessToken(String clientID,String secret, String refreshToken){
    // client_id=$clientID&client_secret=$secret&grant_type=refresh_token&refresh_token=$refreshToken
    return ApiClient.postRequest<RefreshToken>(
        endPoint: "/v3/oauth/token",
        queryParameters: {
          "client_id":clientID,
          "client_secret":secret,
          "grant_type":"refresh_token",
          "refresh_token":refreshToken
        },
        dataConstructor: (data)=>RefreshToken.fromJson(data));
  }

  bool _compareScopes(List<StravaAuthScope> left, List<StravaAuthScope> right){
    return left.every((element) => right.contains(element));
  }
}