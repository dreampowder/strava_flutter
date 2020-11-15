import 'fault.dart';

class Token {
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresAt;
  int expiresIn; // in seconds
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
    ret['expires_in'] = model.expiresIn ?? 'Error';

    return ret;
  }

  static Token fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Token model = new Token();
    model.accessToken = map['access_token'];
    model.refreshToken = map['refresh_token'];
    model.tokenType = map['token_type'];
    model.expiresAt = map['expires_at'];
    model.expiresIn = map['expires_in'];
    return model;
  }
}

class RefreshAnswer {
  Fault fault;
  String accessToken;
  String refreshToken;
  int expiresAt;
  int expiresIn;

  RefreshAnswer();

  factory RefreshAnswer.fromJson(Map<String, dynamic> json) =>
      RefreshAnswer.fromMap(json);

  static RefreshAnswer fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RefreshAnswer model = RefreshAnswer();
    model.accessToken = map['access_token'];
    model.refreshToken = map['refresh_token'];
    model.expiresAt = map['expires_at'];
    model.expiresAt = map['expires_in'];
    return model;
  }
}
