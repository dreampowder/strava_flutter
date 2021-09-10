import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/model/model_authentication_scopes.dart';

class LocalStorageManager{

  static String _kTokenKey = "strava_token";
  static String _kScopesKey = "strava_scopes";

  static Future<bool> saveToken(TokenResponse token,List<AuthenticationScope> scopes) async{
    var sharedPrefs = await SharedPreferences.getInstance();
    token.scopes = AuthenticationScopeHelper.buildScopeString(scopes);
    return sharedPrefs.setString(_kTokenKey, token.toRawJson());
  }

  static Future<bool> deleteToken() async{
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.remove(_kTokenKey);
  }

  static Future<TokenResponse?> getToken() async{
    var sharedPrefs = await SharedPreferences.getInstance();
    var completer = Completer<TokenResponse?>();
    var tokenJson = sharedPrefs.getString(_kTokenKey);
    if (tokenJson == null) {
      completer.complete(null);
    }else{
      completer.complete(TokenResponse.fromRawJson(tokenJson));
    }
    return completer.future;
  }

}