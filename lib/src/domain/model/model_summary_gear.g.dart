// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_summary_gear.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryGear _$SummaryGearFromJson(Map<String, dynamic> json) => SummaryGear(
  id: json['id'] as String,
  primary: json['primary'] as bool,
  name: json['name'] as String,
  resourceState: (json['resource_state'] as num).toInt(),
  distance: (json['distance'] as num).toInt(),
);

Map<String, dynamic> _$SummaryGearToJson(SummaryGear instance) =>
    <String, dynamic>{
      'id': instance.id,
      'primary': instance.primary,
      'name': instance.name,
      'resource_state': instance.resourceState,
      'distance': instance.distance,
    };
