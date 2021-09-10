import 'dart:async';

import 'package:strava_flutter/common/local_storage.dart';
import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/model/model_authentication_scopes.dart';

class SessionManager{

  late final String secret;
  late final String clientId;

  TokenResponse? _currentToken;
  List<AuthenticationScope>? _scopes;

  void initialize({
    required String secret,
    required String clientId
  }){
    this.secret = secret;
    this.clientId = clientId;
  }

  Future<TokenResponse?> getToken(){
    var completer = Completer<TokenResponse?>();
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

  Future<void> setToken({required TokenResponse token,required List<AuthenticationScope> scopes}){
    _currentToken = token;
    _scopes = scopes;
    return LocalStorageManager.saveToken(token,scopes).then((value) => _currentToken = token);
  }

  bool isTokenExpired(TokenResponse token){
    DateTime expiresAt = DateTime.fromMillisecondsSinceEpoch(token.expiresAt * 1000);
    return DateTime.now().isAfter(expiresAt);
  }

  Future<void> logout(){
    _currentToken = null;
    _scopes = null;
    return LocalStorageManager.deleteToken();
  }
}