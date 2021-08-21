import 'dart:convert';

class RefreshToken {
  RefreshToken({
    required this.accessToken,
    required this.expiresAt,
    required this.expiresIn,
    required this.refreshToken,
  });

  final String accessToken;
  final int expiresAt;
  final int expiresIn;
  final String refreshToken;

  factory RefreshToken.fromRawJson(String str) => RefreshToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
    accessToken: json["access_token"],
    expiresAt: json["expires_at"],
    expiresIn: json["expires_in"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_at": expiresAt,
    "expires_in": expiresIn,
    "refresh_token": refreshToken,
  };
}
