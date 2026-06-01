// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
  private: json['private'] as bool?,
  distance: (json['distance'] as num?)?.toDouble(),
  athlete: json['athlete'] == null
      ? null
      : SummaryAthlete.fromJson(json['athlete'] as Map<String, dynamic>),
  description: json['description'] as String?,
  createdAt: json['created_at'] as String?,
  elevationGain: (json['elevation_gain'] as num?)?.toDouble(),
  type: (json['type'] as num?)?.toInt(),
  estimatedMovingTime: (json['estimated_moving_time'] as num?)?.toInt(),
  segments: (json['segments'] as List<dynamic>?)
      ?.map(SummarySegment.fromJson)
      .toList(),
  starred: json['starred'] as bool?,
  updatedAt: json['updated_at'] as String?,
  subType: (json['sub_type'] as num?)?.toInt(),
  idStr: json['id_str'] as String?,
  name: json['name'] as String?,
  id: (json['id'] as num?)?.toInt(),
  map: json['map'] == null
      ? null
      : PolyLineMap.fromJson(json['map'] as Map<String, dynamic>),
  timestamp: (json['timestamp'] as num?)?.toInt(),
);

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
  'private': instance.private,
  'distance': instance.distance,
  'athlete': instance.athlete?.toJson(),
  'description': instance.description,
  'created_at': instance.createdAt,
  'elevation_gain': instance.elevationGain,
  'type': instance.type,
  'estimated_moving_time': instance.estimatedMovingTime,
  'segments': ?instance.segments?.map((e) => e.toJson()).toList(),
  'starred': instance.starred,
  'updated_at': instance.updatedAt,
  'sub_type': instance.subType,
  'id_str': instance.idStr,
  'name': instance.name,
  'id': instance.id,
  'map': instance.map?.toJson(),
  'timestamp': instance.timestamp,
};
