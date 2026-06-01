// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      idStr: json['id_str'] as String?,
      activityId: (json['activity_id'] as num?)?.toInt(),
      externalId: json['external_id'] as String?,
      id: (json['id'] as num?)?.toInt(),
      error: json['error'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'id_str': instance.idStr,
      'activity_id': instance.activityId,
      'external_id': instance.externalId,
      'id': instance.id,
      'error': instance.error,
      'status': instance.status,
    };
