// To parse this JSON data, do
//
//     final authenticationResponse = authenticationResponseFromJson(jsonString);

import 'dart:convert';

class TokenResponse {
  TokenResponse(
      {required this.tokenType,
      required this.expiresAt,
      required this.expiresIn,
      required this.refreshToken,
      required this.accessToken,
      this.athlete,
      this.scopes});

  String tokenType;

  /// The number of seconds since the epoch when the provided access token will
  /// expire.
  int expiresAt;

  /// Seconds until the short-lived access token will expire.
  int expiresIn;

  /// The refresh token for this user, to be used to get the next access token
  /// for this user.
  ///
  /// Please expect that this value can change anytime you retrieve a new access
  /// token. Once a new refresh token code has been returned, the older code
  /// will no longer work.
  String refreshToken;

  /// The access token for this user.
  String accessToken;

  /// A summary of athlete information.
  Athlete? athlete;
  String? scopes;

  factory TokenResponse.fromRawJson(String str) =>
      TokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
      tokenType: json["token_type"],
      expiresAt: json["expires_at"],
      expiresIn: json["expires_in"],
      refreshToken: json["refresh_token"],
      accessToken: json["access_token"],
      athlete:
          json["athlete"] == null ? null : Athlete.fromJson(json["athlete"]),
      scopes: json["scopes"]);

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_at": expiresAt,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "access_token": accessToken,
        "athlete": athlete?.toJson(),
        "scopes": scopes
      };
}

class Athlete {
  Athlete();

  factory Athlete.fromRawJson(String str) => Athlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Athlete.fromJson(Map<String, dynamic> json) => Athlete();

  Map<String, dynamic> toJson() => {};
}
