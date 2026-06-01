// To parse this JSON data, do
//
//     final authenticationResponse = authenticationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_authentication_response.g.dart';

@JsonSerializable()
class TokenResponse {
  TokenResponse({
    required this.tokenType,
    required this.expiresAt,
    required this.expiresIn,
    required this.refreshToken,
    required this.accessToken,
    this.athlete,
    this.scopes,
  });

  @JsonKey(name: "token_type")
  String tokenType;

  /// The number of seconds since the epoch when the provided access token will
  /// expire.
  @JsonKey(name: "expires_at")
  int expiresAt;

  /// Seconds until the short-lived access token will expire.
  @JsonKey(name: "expires_in")
  int expiresIn;

  /// The refresh token for this user, to be used to get the next access token
  /// for this user.
  ///
  /// Please expect that this value can change anytime you retrieve a new access
  /// token. Once a new refresh token code has been returned, the older code
  /// will no longer work.
  @JsonKey(name: "refresh_token")
  String refreshToken;

  /// The access token for this user.
  @JsonKey(name: "access_token")
  String accessToken;

  /// A summary of athlete information.
  @JsonKey(name: "athlete")
  Athlete? athlete;

  @JsonKey(name: "scopes")
  String? scopes;

  factory TokenResponse.fromRawJson(String str) =>
      TokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class Athlete {
  Athlete();

  factory Athlete.fromRawJson(String str) => Athlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Athlete.fromJson(Map<String, dynamic> json) =>
      _$AthleteFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteToJson(this);
}
