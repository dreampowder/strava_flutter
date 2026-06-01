// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_upload_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadActivityRequest _$UploadActivityRequestFromJson(
  Map<String, dynamic> json,
) => UploadActivityRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  isTrainerActivity: json['trainer'] as bool?,
  isCommuteActivity: json['commute'] as bool?,
  dataType: json['data_type'] as String?,
  externalId: json['external_id'] as String?,
);

Map<String, dynamic> _$UploadActivityRequestToJson(
  UploadActivityRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'trainer': instance.isTrainerActivity,
  'commute': instance.isCommuteActivity,
  'data_type': instance.dataType,
  'external_id': instance.externalId,
};
