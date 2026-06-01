// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_stream_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StravaStream _$StravaStreamFromJson(Map<String, dynamic> json) => StravaStream(
  type: json['type'] as String?,
  data: _doubleListFromJson(json['data']),
  seriesType: json['series_type'] as String?,
  originalSize: (json['original_size'] as num?)?.toInt(),
  resolution: json['resolution'] as String?,
);

Map<String, dynamic> _$StravaStreamToJson(StravaStream instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'series_type': instance.seriesType,
      'original_size': instance.originalSize,
      'resolution': instance.resolution,
    };
