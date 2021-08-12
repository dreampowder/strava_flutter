import 'dart:async';

import 'package:strava_flutter/models/token.dart';
import 'package:strava_flutter/common/local_storage.dart';

class SessionManager{

  static SessionManager? _instance;

  SessionManager._();

  static SessionManager get getInstance => _instance ??  SessionManager._();

  Token? _currentToken;

  Future<Token?> getToken(){
    var completer = Completer<Token>();
    if(_currentToken != null){
      completer.complete(_currentToken);
    }else{
      LocalStorageManager
          .getToken()
          .then((storedValue){
            if(storedValue != null){
              _currentToken = storedValue as Token?;
            }
            completer.complete(_currentToken);
      });
    }
    return completer.future;
  }

  Future<void> setToken(Token token){
    _currentToken = token;
    return LocalStorageManager.saveToken(token).then((value) => _currentToken = token);
  }
}