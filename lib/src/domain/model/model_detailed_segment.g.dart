// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_detailed_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedSegment _$DetailedSegmentFromJson(Map<String, dynamic> json) =>
    DetailedSegment(
      id: (json['id'] as num?)?.toInt(),
      resourceState: (json['resource_state'] as num?)?.toInt(),
      name: json['name'] as String?,
      activityType: json['activity_type'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      averageGrade: (json['average_grade'] as num?)?.toDouble(),
      maximumGrade: (json['maximum_grade'] as num?)?.toDouble(),
      elevationHigh: (json['elevation_high'] as num?)?.toDouble(),
      elevationLow: (json['elevation_low'] as num?)?.toDouble(),
      startLatlng: _latLngFromJson(json['start_latlng']),
      endLatlng: _latLngFromJson(json['end_latlng']),
      climbCategory: (json['climb_category'] as num?)?.toInt(),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      private: json['private'] as bool?,
      hazardous: json['hazardous'] as bool?,
      starred: json['starred'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      totalElevationGain: (json['total_elevation_gain'] as num?)?.toDouble(),
      map: json['map'] == null
          ? null
          : PolyLineMap.fromJson(json['map'] as Map<String, dynamic>),
      effortCount: (json['effort_count'] as num?)?.toInt(),
      athleteCount: (json['athlete_count'] as num?)?.toInt(),
      starCount: (json['star_count'] as num?)?.toInt(),
      athleteSegmentStats:
          _athleteSegmentStatsReadValue(json, 'athlete_segment_stats') == null
          ? null
          : SummaryPRSegmentEffort.fromJson(
              _athleteSegmentStatsReadValue(json, 'athlete_segment_stats')
                  as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DetailedSegmentToJson(DetailedSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_state': instance.resourceState,
      'name': instance.name,
      'activity_type': instance.activityType,
      'distance': instance.distance,
      'average_grade': instance.averageGrade,
      'maximum_grade': instance.maximumGrade,
      'elevation_high': instance.elevationHigh,
      'elevation_low': instance.elevationLow,
      'start_latlng': instance.startLatlng,
      'end_latlng': instance.endLatlng,
      'climb_category': instance.climbCategory,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'private': instance.private,
      'hazardous': instance.hazardous,
      'starred': instance.starred,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'total_elevation_gain': instance.totalElevationGain,
      'map': ?instance.map?.toJson(),
      'effort_count': instance.effortCount,
      'athlete_count': instance.athleteCount,
      'star_count': instance.starCount,
      'athlete_segment_stats': ?instance.athleteSegmentStats?.toJson(),
    };
