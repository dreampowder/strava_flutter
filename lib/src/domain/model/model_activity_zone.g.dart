// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_activity_zone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityZone _$ActivityZoneFromJson(Map<String, dynamic> json) => ActivityZone(
  score: (json['score'] as num?)?.toInt(),
  sensorBased: json['sensor_based'] as bool?,
  customZones: json['custom_zones'] as bool?,
  max: (json['max'] as num?)?.toInt(),
  distributionBuckets: json['distribution_buckets'] as String?,
  type: json['type'] as String?,
  points: (json['points'] as num?)?.toInt(),
);

Map<String, dynamic> _$ActivityZoneToJson(ActivityZone instance) =>
    <String, dynamic>{
      'score': instance.score,
      'sensor_based': instance.sensorBased,
      'custom_zones': instance.customZones,
      'max': instance.max,
      'distribution_buckets': instance.distributionBuckets,
      'type': instance.type,
      'points': instance.points,
    };
