// Oauth.dart

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;
import 'constants.dart';
import 'token.dart';
import '../Models/fault.dart';

///===========================================
/// Class related to Authorization processs
///===========================================
abstract class Auth {
  StreamController<String> onCodeReceived = StreamController();

// Save the token and the expiry date
  Future<void> saveToken(String token, int expire, String scope) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('expire', expire); // Stored in seconds
    prefs.setString('scope', scope);

    // Save also in globals to get direct access
    globals.token.accessToken = token;
    globals.token.scope = scope;
    globals.token.expiresAt = expire;

    globals.displayInfo('token saved!!!');
  }

// Get the stored token and expiry date
  Future<Token> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    var localToken = Token();
    globals.displayInfo('Entering getStoredToken');

    try {
      localToken.accessToken = prefs.getString('token').toString();
      localToken.expiresAt = prefs.getInt('expire');
      localToken.scope = prefs.getString('scope');

      // load the data in globals
      globals.token.accessToken = localToken.accessToken;
      globals.token.expiresAt = localToken.expiresAt;
      globals.token.scope = localToken.scope;
    } catch (error) {
      globals.displayInfo('Error getting the key');
      localToken.accessToken = null;
      localToken.expiresAt = null;
      localToken.scope = null;
    }

    if (localToken.expiresAt != null) {
      var dateExpired =
          DateTime.fromMillisecondsSinceEpoch(localToken.expiresAt);
      var _disp = dateExpired.day.toString() +
          '/' +
          dateExpired.month.toString() +
          ' ' +
          dateExpired.hour.toString() +
          'hours';

      globals.displayInfo(
          'stored token ${localToken.accessToken}  expires: $_disp ');
    }

    return (localToken);
  }

  /// Get the code from Strava server
  ///
  Future<void> getStravaCode(
      String clientID, String scope, String prompt) async {
    globals.displayInfo('Entering getStravaCode');
    var code = "";
    var params = '?' +
        'client_id=' +
        clientID +
        '&redirect_uri=' +
        redirectUrl +
        '&response_type=' +
        'code' +
        '&approval_prompt=' +
        prompt +
        '&scope=' +
        scope;

    var reqAuth = authorizationEndpoint + params;
    globals.displayInfo('$reqAuth');

    closeWebView();
    launch(reqAuth,
        forceWebView: true, forceSafariVC: true, enableJavaScript: true);

    // Launch small http server to collect the answer from Strava
    //------------------------------------------------------------
    final server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
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

      globals.displayInfo('Got the new code: $code');
    }
    // });
  }

  /// Do Strava Authentication.
  ///
  /// Do not do/show the Strava login if a token has been stored previously
  /// and is not expired
  /// Do/show the Strava login if the scope has been changed since last storage of the token
  /// return true if no problem in authentication has been found
  Future<bool> Oauth(
      String clientID, String scope, String secret, String prompt) async {
    print('Welcome to Oauth');
    bool isAuthOk = false;
    bool isExpired = true;

    final Token tokenStored = await getStoredToken();
    final String _token = tokenStored.accessToken;

    // Check if the token is not expired
    if (_token != "null") {
      globals.displayInfo(
          'token has been stored before! ${tokenStored.accessToken}');

      isExpired = isTokenExpired(tokenStored);
      globals.displayInfo('isExpired $isExpired');
    }

    // Check if the scope has changed
    if ((tokenStored.scope != scope) || (_token == "null") || isExpired) {
      // Ask for a new authorization
      globals.displayInfo('Doing a new authorization');
      isAuthOk = await newAuthorization(clientID, secret, scope, prompt);
    } else {
      isAuthOk = true;
    }

    return isAuthOk;
  }

  Future<bool> newAuthorization(
      String clientID, String secret, String scope, String prompt) async {
    bool returnValue = false;

    await getStravaCode(clientID, scope, prompt);

    var stravaCode = await onCodeReceived.stream.first;

    if (stravaCode != null) {
      var answer = await getStravaToken(clientID, secret, stravaCode);

      globals
          .displayInfo('answer ${answer.expiresAt}  , ${answer.accessToken}');

      // Save the token information
      if (answer.accessToken != null && answer.expiresAt != null) {
        await saveToken(answer.accessToken, answer.expiresAt, scope);
        returnValue = true;
      }
    } else {
      globals.displayInfo('code is still null');
    }
    return returnValue;
  }

  Future<Token> getStravaToken(
      String clientID, String secret, String code) async {
    Token _answer = Token();

    globals.displayInfo('Entering getStravaToken!!');
    var urlToken = tokenEndpoint +
        '?client_id=' +
        clientID +
        '&client_secret=' +
        secret + // Put your own secret in secret.dart
        '&code=' +
        code +
        '&grant_type=' +
        'authorization_code';

    globals.displayInfo('urlToken $urlToken');

    var value = await http.post(urlToken);

    // responseToken.then((value) {
    globals.displayInfo('body ${value.body}');

    if (value.body.contains('message')) {
      // This is not the normal message
      globals.displayInfo('Error in getStravaToken');
      // will return _answer null
    } else {
      var tokenBody = json.decode(value.body);
      // Todo: handle error with message "Authorization Error" and errors != null
      var _body = Token.fromJson(tokenBody);
      var accessToken = _body.accessToken;
      var refreshToken = _body.refreshToken;
      var expiresAt = _body.expiresAt * 1000;

      _answer.accessToken = accessToken;
      _answer.refreshToken = refreshToken;
      _answer.expiresAt = expiresAt;
    }

    return (_answer);
  }

  bool isTokenExpired(Token token) {
    final DateTime _expiryDate =
        DateTime.fromMillisecondsSinceEpoch(token.expiresAt);
    return (_expiryDate.isBefore(DateTime.now()));
  }

  /// To revoke the current token
  /// Useful when doing test to force the Strava login
  ///
  /// scope needed: none
  ///
  Future<Fault> deAuthorize() async {
    Fault fault = Fault(globals.statusUnknownError, '');

    var _header = globals.createHeader();
    if (_header != null) {
      final reqDeAuthorize = "https://www.strava.com/oauth/deauthorize";
      var rep = await http.post(reqDeAuthorize, headers: _header);
      if (rep.statusCode == 200) {
        globals.displayInfo('DeAuthorize done');
        await saveToken(null, null, null);
        fault.statusCode = globals.statusOk;
      } else {
        globals.displayInfo('Problem in deAuthorize request');
        fault.statusCode = globals.statusOk;
      }
    }
    return fault;
  }
}
