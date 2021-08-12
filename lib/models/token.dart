import 'dart:convert';


class Token{
  Token({
    required this.tokenType,
    required this.expiresAt,
    required this.expiresIn,
    required this.refreshToken,
    required this.accessToken,
    this.scopes
  });

  final String tokenType;
  final int expiresAt;
  final int expiresIn;
  final String refreshToken;
  final String accessToken;
  String? scopes;

  factory Token.empty() => Token(tokenType: "", expiresAt: 0, expiresIn: 0, refreshToken: "", accessToken: "");
  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    tokenType: json["token_type"],
    expiresAt: json["expires_at"],
    expiresIn: json["expires_in"],
    refreshToken: json["refresh_token"],
    accessToken: json["access_token"],
    scopes: json["scopes"]
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "expires_at": expiresAt,
    "expires_in": expiresIn,
    "refresh_token": refreshToken,
    "access_token": accessToken,
    "scoped":scopes
  };
}
