// oauth.dart

import 'dart:async';
import 'dart:io'; // Use in web mode only

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'constants.dart';
import 'package:strava_flutter/api/api_constants.dart';
import 'package:strava_flutter/globals.dart' as globals;
// import '../models/fault.dart';
import 'package:strava_flutter/models/fault.dart';
// import '../models/token.dart';
import 'package:strava_flutter/models/token.dart';
// To handle browser return after auth is done
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

///===========================================
/// Class related to Authorization processs
///===========================================
abstract class Auth {
  StreamController<String?> onCodeReceived = StreamController();

  /// Save the token and the expiry date
  Future<void> _saveToken(
    String? token,
    int? expiresAt,
    int? expiresIn,
    String? scope,
    String? refreshToken,
  ) async {
    // final prefs = await SharedPreferences.getInstance();
    // if (token != null) prefs.setString('strava_accessToken', token);
    // if (expiresAt != null)
    //   prefs.setInt('strava_expiresAt', expiresAt); // Stored in seconds
    // // prefs.setInt('strava_expiresIn',
    // //     expiresIn); // Value is valid at the time the token has been issued
    // if (scope != null) prefs.setString('strava_scope', scope);
    // if (refreshToken != null)
    //   prefs.setString('strava_refreshToken', refreshToken);
    //
    // // Save also in globals to get direct access
    // globals.token.accessToken = token;
    // globals.token.scope = scope;
    // globals.token.expiresAt = expiresAt;
    // // globals.token.expiresIn = expiresIn;
    // globals.token.refreshToken = refreshToken;
    //
    // globals.displayInfo('token saved!!!');
    throw UnimplementedError();
  }

  // remove token
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('strava_accessToken');
    prefs.remove('strava_expiresAt');
    prefs.remove('strava_scope');
    prefs.remove('strava_refreshToken');
    globals.token = null;
  }

  /// Get the stored token and expiry date
  ///
  /// And refreshToken as well
  /// Stored them in globals.token
  ///
  Future<Token> getStoredToken() async {
    throw UnimplementedError();
    // final prefs = await SharedPreferences.getInstance();
    // var localToken = Token.empty();
    // globals.displayInfo('Entering getStoredToken');
    //
    // try {
    //
    //   localToken.accessToken = prefs.getString('strava_accessToken');
    //   // localToken.expiresAt = prefs.getInt('expire') * 1000; // To get in ms
    //   localToken.expiresAt = prefs.getInt('strava_expiresAt');
    //   // localToken.expiresIn = prefs.getInt(('strava_expiresIn'));
    //   localToken.scope = prefs.getString('strava_scope');
    //   localToken.refreshToken = prefs.getString('strava_refreshToken');
    //
    //   // load the data in globals
    //   globals.token.accessToken = localToken.accessToken;
    //   globals.token.expiresAt = localToken.expiresAt;
    //   // globals.token.expiresIn = localToken
    //   //     .expiresIn; // Value was validwhen the server sent info about the token
    //   globals.token.scope = localToken.scope;
    //   globals.token.refreshToken = localToken.refreshToken;
    // } catch (error) {
    //   globals.displayInfo('Error while retrieving the token');
    //   localToken.accessToken = null;
    //   localToken.expiresAt = null;
    //   // localToken.expiresIn = null;
    //   localToken.scope = null;
    // }
    //
    // if (localToken.expiresAt != null) {
    //   final dateExpired =
    //       DateTime.fromMillisecondsSinceEpoch(localToken.expiresAt!);
    //   final _disp =
    //       '${dateExpired.day.toString()}/${dateExpired.month.toString()} ${dateExpired.hour.toString()} hours';
    //   globals.displayInfo(
    //       'stored token ${localToken.accessToken} ${localToken.expiresAt} expires: $_disp ');
    // }
    //
    // return (localToken);
  }

  /// Get the code from Strava server
  ///
  Future<void> _getStravaCode(
    String? clientID,
    String? scope,
    String? prompt,
  ) async {
    globals.displayInfo('Entering getStravaCode');
    String? code = "";

    String redirectUrl;

    if (kIsWeb == true) {
      redirectUrl = redirectUrlWeb;
    } else {
      redirectUrl = redirectUrlMobile;
    }

    final params =
        '?client_id=$clientID&redirect_uri=$redirectUrl&response_type=code&approval_prompt=$prompt&scope=$scope';

    final reqAuth = authorizationEndpoint + params;
    globals.displayInfo(reqAuth);
    late StreamSubscription _sub;

    // closeWebView();
    launch(reqAuth,
        forceWebView: false,
        // forceWebView: true,
        forceSafariVC: false,
        enableJavaScript: true);
    //--------  NOT working yet on web
    if (kIsWeb) {
      globals.displayInfo('Running in web ');

      // listening on http the answer from Strava
      final server =
          await HttpServer.bind(InternetAddress.anyIPv4, 8080, shared: true);
      await for (HttpRequest request in server) {
        // Get the answer from Strava
        // final uri = request.uri;
        globals.displayInfo(
            'Get the answer from Strava to authenticate! ${request.uri}');
      }
    } else {
      globals.displayInfo('Running on iOS or Android');

      // Attach a listener to the stream
      _sub = uriLinkStream.listen((Uri? uri) {
        // Parse the link and warn the user, if it is not correct
        globals.displayInfo('Get a link!! $uri');
        if (uri?.scheme.compareTo('stravaflutter_$clientID') != 0) {
          globals.displayInfo('This is not the good scheme ${uri?.scheme}');
        }
        code = uri?.queryParameters["code"];
        final error = uri?.queryParameters["error"];

        globals.displayInfo('code $code, error $error');

        closeWebView();
        onCodeReceived.add(code);

        globals.displayInfo('Got the new code: $code');

        _sub.cancel();
      }, onError: (err) {
        // Handle exception by warning the user their action did not succeed
        globals.displayInfo('Found an error $err');
        _sub.cancel();
      });
    }

/****
    if (Platform.isIOS) {
      // Launch small http server to collect the answer from Strava
      //------------------------------------------------------------
      final server =
          // await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
          await HttpServer.bind(InternetAddress.loopbackIPv4, 8080,
              shared: true);
      // server.listen((HttpRequest request) async {
      await for (HttpRequest request in server) {
        // Get the answer from Strava
        final uri = request.uri;

        code = uri.queryParameters["code"];
        final error = uri.queryParameters["error"];
        request.response.close();
        globals.displayInfo('code $code, error $error');

        closeWebView();
        server.close(force: true);

        onCodeReceived.add(code);

        globals.displayInfo('iOS Got the new code: $code');
      }
    }
    // });
***/
  }

  /// Do Strava Authentication.
  ///
  /// Do not do/show the Strava login if a token has been stored previously
  /// and is not expired
  ///
  /// Do/show the Strava login if the scope has been changed since last storage of the token
  /// return true if no problem in authentication has been found
  Future<bool> oauth(
    String? clientID,
    String? scope,
    String? secret,
    String? prompt,
  ) async {
    throw UnimplementedError();
    // globals.displayInfo('Welcome to Oauth');
    // bool isAuthOk = false;
    // bool isExpired;
    //
    // final Token tokenStored = await getStoredToken();
    // final String? _token = tokenStored.accessToken;
    //
    // isExpired = _isTokenExpired(tokenStored);
    // globals.displayInfo('is token expired? $isExpired');
    //
    // // Check if the token is not expired
    // // if (_token != null) {
    // if (_token != null && _token != "null") {
    //   globals.displayInfo(
    //       'token has been stored before! ${tokenStored.accessToken}  exp. ${tokenStored.expiresAt}');
    // }
    //
    // // Use the refresh token to get a new access token
    // if (isExpired && _token != null && _token != "null") {
    //   RefreshAnswer _refreshAnswer =
    //       await _getNewAccessToken(clientID, secret, tokenStored.refreshToken);
    //   // Update with new values
    //   if (_refreshAnswer.fault.statusCode == 200) {
    //     await _saveToken(_refreshAnswer.accessToken!, _refreshAnswer.expiresAt!,
    //         _refreshAnswer.expiresIn, scope, _refreshAnswer.refreshToken!);
    //   } else {
    //     globals.displayInfo('Problem doing the refresh process');
    //     isAuthOk = false;
    //   }
    // }
    //
    // // Check if the scope has changed
    // if (tokenStored.scope != scope || _token == "null" || _token == null) {
    //   // Ask for a new authorization
    //   globals.displayInfo('Doing a new authorization');
    //   isAuthOk = await _newAuthorization(clientID, secret, scope, prompt);
    // } else {
    //   isAuthOk = true;
    // }
    //
    // return isAuthOk;
  }

  // Future<bool> _newAuthorization(
  //   String? clientID,
  //   String? secret,
  //   String? scope,
  //   String? prompt,
  // ) async {
  //   bool returnValue = false;
  //
  //   await _getStravaCode(clientID, scope, prompt);
  //
  //   final stravaCode = await onCodeReceived.stream.first;
  //
  //   if (stravaCode != null) {
  //     final answer = await _getStravaToken(clientID, secret, stravaCode);
  //
  //     globals.displayInfo('answer ${answer.expiresAt}, ${answer.accessToken}');
  //
  //     // Save the token information
  //     if (answer.accessToken != null && answer.expiresAt != null) {
  //       await _saveToken(answer.accessToken!, answer.expiresAt!,
  //           answer.expiresIn, scope, answer.refreshToken!);
  //       returnValue = true;
  //     }
  //   } else {
  //     globals.displayInfo('code is still null');
  //   }
  //   return returnValue;
  // }

  /// _getNewAccessToken
  /// Ask to Strava a new access token
  /// Return
  ///   accessToken
  ///   refreshToken (because Strava can change it when asking for new access token)
  // Future<RefreshAnswer> _getNewAccessToken(
  //   String? clientID,
  //   String? secret,
  //   String? refreshToken,
  // ) async {
  //   RefreshAnswer returnToken = RefreshAnswer();
  //
  //   final urlRefresh =
  //       'https://www.strava.com/oauth/token?client_id=$clientID&client_secret=$secret&grant_type=refresh_token&refresh_token=$refreshToken';
  //
  //   globals.displayInfo('Entering getNewAccessToken');
  //   // globals.displayInfo('urlRefresh $urlRefresh');
  //
  //   final resp = await http.post(Uri.parse(urlRefresh));
  //
  //   globals.displayInfo('body ${resp.body}');
  //   if (resp.statusCode == 200) {
  //     returnToken = RefreshAnswer.fromJson(json.decode(resp.body));
  //
  //     globals.displayInfo('new exp. date: ${returnToken.expiresAt}');
  //   } else {
  //     globals.displayInfo('Error while refreshing the token');
  //   }
  //
  //   returnToken.fault = globals.errorCheck(resp.statusCode, resp.reasonPhrase);
  //   return returnToken;
  // }

  // Future<Token> _getStravaToken(
  //   String? clientID,
  //   String? secret,
  //   String? code,
  // ) async {
  //   Token _answer = Token();
  //
  //   globals.displayInfo('Entering getStravaToken!!');
  //   // Put your own secret in secret.dart
  //   final urlToken =
  //       '$tokenEndpoint?client_id=$clientID&client_secret=$secret&code=$code&grant_type=authorization_code';
  //
  //   globals.displayInfo('urlToken $urlToken');
  //
  //   final value = await http.post(Uri.parse(urlToken));
  //
  //   globals.displayInfo('body ${value.body}');
  //
  //   if (value.body.contains('message')) {
  //     // This is not the normal message
  //     globals.displayInfo('Error in getStravaToken');
  //     // will return _answer null
  //   } else {
  //     final Map<String, dynamic>? tokenBody = json.decode(value.body);
  //     final Token _body = Token.fromJson(tokenBody);
  //     final accessToken = _body.accessToken;
  //     final refreshToken = _body.refreshToken;
  //     // final expiresAt = _body.expiresAt * 1000; // To get the exp. date in ms
  //     final expiresAt = _body.expiresAt; // To get the exp. date in ms
  //
  //     _answer.accessToken = accessToken;
  //     _answer.refreshToken = refreshToken;
  //     _answer.expiresAt = expiresAt;
  //   }
  //
  //   return (_answer);
  // }

  /// Return true the expiry date is passed
  ///
  /// Otherwise return false
  ///
  /// including when there is no token yet
  // bool _isTokenExpired(Token token) {
  //   globals.displayInfo(
  //       ' current time in ms ${DateTime.now().millisecondsSinceEpoch / 1000}   exp. time: ${token.expiresAt}');
  //
  //   // when it is the first run or after a deAuthotrize
  //   if (token.expiresAt == null) {
  //     return false;
  //   }
  //
  //   if (token.expiresAt! < DateTime.now().millisecondsSinceEpoch / 1000) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  /// To revoke the current token
  /// Useful when doing test to force the Strava login
  ///
  /// scope needed: none
  ///
  ///return codes:
  /// statusOK or statusNoAuthenticationYet
  Future<Fault> deAuthorize() async {
    throw UnimplementedError();
    // Fault fault = Fault(error.statusUnknownError, '');
    //
    // if (globals.token.accessToken == null) {
    //   // Token has not been yet stored in memory
    //   await getStoredToken();
    // }
    //
    // final _header = globals.createHeader();
    //
    // // If header is not "empty"
    // if (_header.containsKey('88') == false) {
    //   final reqDeAuthorize = "https://www.strava.com/oauth/deauthorize";
    //   globals.displayInfo('request $reqDeAuthorize');
    //   final rep = await http.post(Uri.parse(reqDeAuthorize), headers: _header);
    //   if (rep.statusCode == 200) {
    //     globals.displayInfo('DeAuthorize done');
    //     globals.displayInfo('response ${rep.body}');
    //     await _removeToken();
    //     fault.statusCode = error.statusOk;
    //     fault.message = 'DeAuthorize done';
    //   } else {
    //     await _removeToken();
    //     globals.displayInfo('Problem in deAuthorize request');
    //     fault.statusCode = error.statusDeAuthorizeError;
    //   }
    // } else {
    //   // No authorization has been done before
    //   globals.displayInfo('No Authentication has been done yet');
    //   fault.statusCode = error.statusNoAuthenticationYet;
    //   fault.message = 'No Authentication has been done yet';
    // }
    //
    // return fault;
  }
}
