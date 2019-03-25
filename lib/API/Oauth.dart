// oauth.dart

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as globals;
import 'constants.dart';
import '../Models/token.dart';
import '../Models/fault.dart';

///===========================================
/// Class related to Authorization processs
///===========================================
abstract class Auth {
  StreamController<String> onCodeReceived = StreamController();

  /// Save the token and the expiry date
  Future<void> _saveToken(
      String token, int expire, String scope, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
    prefs.setInt('expire', expire); // Stored in seconds
    prefs.setString('scope', scope);
    prefs.setString('refreshToken', refreshToken);

    // Save also in globals to get direct access
    globals.token.accessToken = token;
    globals.token.scope = scope;
    globals.token.expiresAt = expire;
    globals.token.refreshToken = refreshToken;

    globals.displayInfo('token saved!!!');
  }

  /// Get the stored token and expiry date
  ///
  /// And refreshToken as well
  ///
  Future<Token> _getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    var localToken = Token();
    globals.displayInfo('Entering getStoredToken');

    try {
      localToken.accessToken = prefs.getString('accessToken').toString();
      localToken.expiresAt = prefs.getInt('expire') * 1000; // To get in ms
      localToken.scope = prefs.getString('scope');
      localToken.refreshToken = prefs.getString('refreshToken');

      // load the data in globals
      globals.token.accessToken = localToken.accessToken;
      globals.token.expiresAt = localToken.expiresAt;
      globals.token.scope = localToken.scope;
      globals.token.refreshToken = localToken.refreshToken;
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
          'stored token ${localToken.accessToken} ${localToken.expiresAt} expires: $_disp ');
    }

    return (localToken);
  }

  /// Get the code from Strava server
  ///
  Future<void> _getStravaCode(
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
  ///
  /// Do/show the Strava login if the scope has been changed since last storage of the token
  /// return true if no problem in authentication has been found
  Future<bool> oauth(
      String clientID, String scope, String secret, String prompt) async {
    globals.displayInfo('Welcome to Oauth');
    bool isAuthOk = false;
    bool isExpired = true;

    final Token tokenStored = await _getStoredToken();
    final String _token = tokenStored.accessToken;

    // Check if the token is not expired
    // if (_token != null) {
    if ((_token != null) || (_token == "null")) {
      globals.displayInfo(
          'token has been stored before! ${tokenStored.accessToken}  exp. ${tokenStored.expiresAt}');

      isExpired = _isTokenExpired(tokenStored);
      globals.displayInfo('isExpired $isExpired');
    }

    // Use the refresh token to get a new access token
    if (isExpired && ((_token != "null") || (_token != null))) {
      RefreshAnswer _refreshAnswer =
          await _getNewAccessToken(clientID, secret, tokenStored.refreshToken);
      // Update with new values (only refreshToken is unchanged)
      if (_refreshAnswer.fault.statusCode == 200) {
        _saveToken(_refreshAnswer.accessToken, _refreshAnswer.expiresAt, scope,
            tokenStored.refreshToken);
      } else {
        globals.displayInfo('Problem doing the refresh process');
        isAuthOk = false;
      }
    }

    // Check if the scope has changed
    if ((tokenStored.scope != scope) || (_token == "null")) {
      // Ask for a new authorization
      globals.displayInfo('Doing a new authorization');
      isAuthOk = await _newAuthorization(clientID, secret, scope, prompt);
    } else {
      isAuthOk = true;
    }

    return isAuthOk;
  }

  Future<bool> _newAuthorization(
      String clientID, String secret, String scope, String prompt) async {
    bool returnValue = false;

    await _getStravaCode(clientID, scope, prompt);

    var stravaCode = await onCodeReceived.stream.first;

    if (stravaCode != null) {
      var answer = await _getStravaToken(clientID, secret, stravaCode);

      globals
          .displayInfo('answer ${answer.expiresAt}  , ${answer.accessToken}');

      // Save the token information
      if (answer.accessToken != null && answer.expiresAt != null) {
        await _saveToken(
            answer.accessToken, answer.expiresAt, scope, answer.refreshToken);
        returnValue = true;
      }
    } else {
      globals.displayInfo('code is still null');
    }
    return returnValue;
  }

  Future<RefreshAnswer> _getNewAccessToken(
      String clientID, String secret, String refreshToken) async {
    RefreshAnswer returnToken = RefreshAnswer();

        var urlRefresh =
        'https://www.strava.com/oauth/token?client_id=$clientID&client_secret=$secret&grant_type=refresh_token&refresh_token=$refreshToken';


    globals.displayInfo('Entering getNewAccessToken');
    globals.displayInfo('urlRefresh $urlRefresh');

    var resp = await http.post(urlRefresh);

    globals.displayInfo('body ${resp.body}');
    if (resp.statusCode == 200) {
      returnToken = RefreshAnswer.fromJson(json.decode(resp.body));
      globals.displayInfo('new exp. date: ${returnToken.expiresAt}');
    } else {
      globals.displayInfo('Error while refreshing the token');
    }

    returnToken.fault = globals.errorCheck(resp.statusCode, resp.reasonPhrase);
    return returnToken;
  }

  Future<Token> _getStravaToken(
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

    globals.displayInfo('body ${value.body}');

    if (value.body.contains('message')) {
      // This is not the normal message
      globals.displayInfo('Error in getStravaToken');
      // will return _answer null
    } else {
      var tokenBody = json.decode(value.body);
      var _body = Token.fromJson(tokenBody);
      var accessToken = _body.accessToken;
      var refreshToken = _body.refreshToken;
      var expiresAt = _body.expiresAt * 1000; // To get the exp. date in ms

      _answer.accessToken = accessToken;
      _answer.refreshToken = refreshToken;
      _answer.expiresAt = expiresAt;
    }

    return (_answer);
  }

  bool _isTokenExpired(Token token) {
    // final DateTime _expiryDate =
        DateTime.fromMillisecondsSinceEpoch(token.expiresAt);
    print(' current time in ms ${DateTime.now().millisecondsSinceEpoch}   exp. time: ${token.expiresAt}');
    if (token.expiresAt < DateTime.now().millisecondsSinceEpoch) {
      return true;
    } else {
      return false;
    }

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
        await _saveToken(null, null, null, null);
        fault.statusCode = globals.statusOk;
      } else {
        globals.displayInfo('Problem in deAuthorize request');
        fault.statusCode = globals.statusOk;
      }
    }
    return fault;
  }
}
