// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_segments_explore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExplorerResponse _$ExplorerResponseFromJson(Map<String, dynamic> json) =>
    ExplorerResponse(
      segments: (json['segments'] as List<dynamic>?)
          ?.map((e) => ExplorerSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExplorerResponseToJson(ExplorerResponse instance) =>
    <String, dynamic>{
      'segments': ?instance.segments?.map((e) => e.toJson()).toList(),
    };

ExplorerSegment _$ExplorerSegmentFromJson(Map<String, dynamic> json) =>
    ExplorerSegment(
      id: (json['id'] as num?)?.toInt(),
      resourceState: (json['resource_state'] as num?)?.toInt(),
      name: json['name'] as String?,
      climbCategory: (json['climb_category'] as num?)?.toInt(),
      climbCategoryDesc: json['climb_category_desc'] as String?,
      avgGrade: (json['avg_grade'] as num?)?.toDouble(),
      startLatlng: _latLngFromJson(json['start_latlng']),
      endLatlng: _latLngFromJson(json['end_latlng']),
      elevDifference: (json['elev_difference'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      points: json['points'] as String?,
      starred: json['starred'] as bool?,
    );

Map<String, dynamic> _$ExplorerSegmentToJson(ExplorerSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_state': instance.resourceState,
      'name': instance.name,
      'climb_category': instance.climbCategory,
      'climb_category_desc': instance.climbCategoryDesc,
      'avg_grade': instance.avgGrade,
      'start_latlng': instance.startLatlng,
      'end_latlng': instance.endLatlng,
      'elev_difference': instance.elevDifference,
      'distance': instance.distance,
      'points': instance.points,
      'starred': instance.starred,
    };
