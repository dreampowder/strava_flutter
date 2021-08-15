import 'dart:async';

import 'package:strava_flutter/models/strava_auth_scopes.dart';
import 'package:strava_flutter/models/token.dart';
import 'package:strava_flutter/common/local_storage.dart';

class SessionManager{

  static SessionManager? _instance;
  late final String secret;
  late final String clientId;

  SessionManager._();

  static SessionManager get getInstance{
    if (_instance == null) {
      _instance = SessionManager._();
    }
    return _instance!;
  }

  Token? _currentToken;
  List<StravaAuthScope>? _scopes;

  void initialize({
    required String secret,
    required String clientId
  }){
    this.secret = secret;
    this.clientId = clientId;
  }

  Future<Token?> getToken(){
    var completer = Completer<Token>();
    if(_currentToken != null){
      completer.complete(_currentToken);
    }else{
      LocalStorageManager
          .getToken()
          .then((storedValue){
            if(storedValue != null){
              _currentToken = storedValue;
            }
            completer.complete(_currentToken);
      });
    }
    return completer.future;
  }

  Future<void> setToken({required Token token,required List<StravaAuthScope> scopes}){
    _currentToken = token;
    _scopes = scopes;
    return LocalStorageManager.saveToken(token,scopes).then((value) => _currentToken = token);
  }

  bool isTokenExpired(Token token){
    DateTime expiresAt = DateTime.fromMillisecondsSinceEpoch(token.expiresAt * 1000);
    return DateTime.now().isAfter(expiresAt);
  }
}