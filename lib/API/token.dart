import 'package:shared_preferences/shared_preferences.dart';

class Token {
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresAt;
  String scope;

  Token();

  factory Token.fromJson(Map<String, dynamic> json) => Token.fromMap(json);

  Map toMap() => Token.toJsonMap(this);

  @override
  String toString() => Token.toJsonMap(this).toString();

  static Map toJsonMap(Token model) {
    Map ret = new Map();
    ret['access_token'] = model.accessToken ?? 'Error';
    ret['token_type'] = model.tokenType ?? 'Error';
    ret['refresh_token'] = model.refreshToken ?? 'Error';
    ret['expires_at'] = model.expiresAt ?? 'Error';

    return ret;
  }

  static Token fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Token model = new Token();
    model.accessToken = map['access_token'];
    model.refreshToken = map['refresh_token'];
    model.tokenType = map['token_type'];
    model.expiresAt = map['expires_at'];
    return model;
  }


  // NOT used for the moment
  //-------------------------
  Future<Token> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    var localToken = Token();
    try {
      localToken.accessToken = prefs.getString('token').toString();
      localToken.expiresAt = prefs.getInt('expire');
      localToken.scope = prefs.getString('scope');

      //  the header
      // header is global to change TODO:
      // header = {'Authorization': 'Bearer ${localToken.accessToken}'};
    } catch (error) {
      print('Error getting the key');
      localToken.accessToken = null;
      localToken.expiresAt = null;
      localToken.scope = null;
    }
    return localToken;

  }
}
