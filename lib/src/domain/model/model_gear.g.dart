// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_gear.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gear _$GearFromJson(Map<String, dynamic> json) => Gear(
  id: json['id'] as String?,
  primary: json['primary'] as bool?,
  resourceState: (json['resource_state'] as num?)?.toInt(),
  distance: (json['distance'] as num?)?.toInt(),
  brandName: json['brand_name'] as String?,
  modelName: json['model_name'] as String?,
  frameType: (json['frame_type'] as num?)?.toInt(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$GearToJson(Gear instance) => <String, dynamic>{
  'id': instance.id,
  'primary': instance.primary,
  'resource_state': instance.resourceState,
  'distance': instance.distance,
  'brand_name': instance.brandName,
  'model_name': instance.modelName,
  'frame_type': instance.frameType,
  'description': instance.description,
};
