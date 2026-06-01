// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_zones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zones _$ZonesFromJson(Map<String, dynamic> json) => Zones(
  distributionBuckets: (json['distribution_buckets'] as List<dynamic>)
      .map((e) => DistributionBucket.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: json['type'] as String,
  resourceState: (json['resource_state'] as num).toInt(),
  sensorBased: json['sensor_based'] as bool,
);

Map<String, dynamic> _$ZonesToJson(Zones instance) => <String, dynamic>{
  'distribution_buckets': instance.distributionBuckets
      .map((e) => e.toJson())
      .toList(),
  'type': instance.type,
  'resource_state': instance.resourceState,
  'sensor_based': instance.sensorBased,
};

DistributionBucket _$DistributionBucketFromJson(Map<String, dynamic> json) =>
    DistributionBucket(
      max: (json['max'] as num).toInt(),
      min: (json['min'] as num).toInt(),
      time: (json['time'] as num).toInt(),
    );

Map<String, dynamic> _$DistributionBucketToJson(DistributionBucket instance) =>
    <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
      'time': instance.time,
    };
