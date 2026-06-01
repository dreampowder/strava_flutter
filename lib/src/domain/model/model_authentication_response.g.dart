// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_authentication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      tokenType: json['token_type'] as String,
      expiresAt: (json['expires_at'] as num).toInt(),
      expiresIn: (json['expires_in'] as num).toInt(),
      refreshToken: json['refresh_token'] as String,
      accessToken: json['access_token'] as String,
      athlete: json['athlete'] == null
          ? null
          : Athlete.fromJson(json['athlete'] as Map<String, dynamic>),
      scopes: json['scopes'] as String?,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'expires_at': instance.expiresAt,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'access_token': instance.accessToken,
      'athlete': instance.athlete?.toJson(),
      'scopes': instance.scopes,
    };

Athlete _$AthleteFromJson(Map<String, dynamic> json) => Athlete();

Map<String, dynamic> _$AthleteToJson(Athlete instance) => <String, dynamic>{};
