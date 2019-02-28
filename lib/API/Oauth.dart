// Oauth.dart

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'constants.dart';
import 'token.dart';


import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';



//===========================================
// Code related to Authorization processs
//===========================================

abstract class Auth {


StreamController<String> onCodeReceived = StreamController();

// Save the token and the expiry date
  void _saveToken(String token, int expire, String scope) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('expire', expire); // Stored in seconds
    prefs.setString('scope', scope);

    print('token saved!!!');
  }

// get the stored token and expiry date
  Future<Token> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    var localToken = Token();
    try {
      localToken.accessToken = prefs.getString('token').toString();
      localToken.expiresAt = prefs.getInt('expire');
      localToken.scope = prefs.getString('scope');

    } catch (error) {
      print('Error getting the key');
      localToken.accessToken = null;
      localToken.expiresAt = null;
      localToken.scope = null;
    }

    if (localToken.expiresAt != null) {
      var dateExpired =
          DateTime.fromMillisecondsSinceEpoch(localToken.expiresAt);
      var disp = dateExpired.day.toString() +
          dateExpired.month.toString() +
          dateExpired.hour.toString();
      print('stored token ${localToken.accessToken}  expires: $disp ');
    }

    return (localToken);
  }



  Map<String, String> createHeader(String token) {
    return  {'Authorization': 'Bearer $token'};

  }

  // Get the code from Strava server 
  Future<void> _getStravaCode(
      String clientID, String redirectUrl, String scope) async {
    print('Welcome to getStravaCode');
    var code = "";
    var params = '?' +
        'client_id=' +
        clientID +
        '&redirect_uri=' +
        redirectUrl +
        '&response_type=' +
        'code' +
        '&approval_prompt=' +
        'auto' +
        // '&scope=' + 'read,read_all,profile:read_all';
        '&scope=' +
        scope;

    var reqAuth = authorizationEndpoint + params;
    print('---> $reqAuth');

    closeWebView();
    launch(reqAuth,
        forceWebView: true, forceSafariVC: true, enableJavaScript: true);

    // Launch small http server to collect the answer from Strava
    //------------------------------------------------------------
    final server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
    server.listen((HttpRequest request) async {
      // Get the answer from Strava
      final uri = request.uri;

      code = uri.queryParameters["code"];
      final error = uri.queryParameters["error"];
      print('---> code $code, error $error');

      closeWebView();
      server.close(force: true);

      onCodeReceived.add(code);
    });

    print('End of getStravaCode');
  }

  Future<Token> _getStravaToken(String clientID, String secret, String code) async {
    Token _answer = Token();

    print('---> Entering getStravaToken!!');
    var urlToken = tokenEndpoint +
        '?client_id=' +
        clientID +
        '&client_secret=' +
        secret + // Put your own secret in secret.dart
        '&code=' +
        code +
        '&grant_type=' +
        'authorization_code';

    print('----> urlToken $urlToken');

    var value = await http.post(urlToken);

    // responseToken.then((value) {
    print('----> body ${value.body}');

    if (value.body.contains('message')) {
      // This is not the normal message
      print('---> Error in getStravaToken');
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
    // });
  }

  bool _isTokenExpired(Token token) {
    final DateTime _expiryDate =
        DateTime.fromMillisecondsSinceEpoch(token.expiresAt);
    return (_expiryDate.isBefore(DateTime.now()));
  }

  Future<bool> OAuth(String clientID, String redirectUrl, String scope, String secret) async {
    bool isExpired = true;
    bool returnValue = false;

    final Token tokenStored = await getStoredToken();
    final String _token = tokenStored.accessToken;

    // Check if the token is not expired
    if (_token != "null") {
      print('----> token has been stored before! ${tokenStored.accessToken}');

      isExpired = _isTokenExpired(tokenStored);
    }

    // Check if access token has been stored previously or expired
    if ((_token == "null") || (isExpired)) {

      // todo: if accessToken is expired use the refresh token
      // to get a new access code
      await _getStravaCode(clientID, redirectUrl, scope);

      onCodeReceived.stream.listen((stravaCode) async {
        if (stravaCode != null) {
          var answer = await _getStravaToken(clientID, secret, stravaCode);

          print('---> answer ${answer.expiresAt}  , ${answer.accessToken}');

          // Save the token information
          if (answer.accessToken != null && answer.expiresAt != null) {
               _saveToken(answer.accessToken, answer.expiresAt, scope);
          }

          returnValue = true;
        } else {
          print('----> code is still null');
          returnValue = false;
        }
      });
    } else {
      
      returnValue = true;
    }

    return (returnValue);
  }

  Future<void> deAuthorize() async {
    String returnValue;

    var _token = await getStoredToken();

    var header = createHeader(_token.accessToken)
    if (header != null) {
      final reqDeAuthorize = "https://www.strava.com/oauth/deauthorize";
      var rep = await http.post(reqDeAuthorize, headers: header);
      if (rep.statusCode == 200) {
        print('DeAuthorize done');
        _saveToken(null, null);
      } else {
        print('problem in deAuthorize request');
        // Todo add an error code
      }
    }
  }



}