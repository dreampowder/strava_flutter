// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_activity_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityStats _$ActivityStatsFromJson(
  Map<String, dynamic> json,
) => ActivityStats(
  recentRunTotals: json['recent_run_totals'] == null
      ? null
      : ActivityTotal.fromJson(
          json['recent_run_totals'] as Map<String, dynamic>,
        ),
  allRunTotals: json['all_run_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['all_run_totals'] as Map<String, dynamic>),
  recentSwimTotals: json['recent_swim_totals'] == null
      ? null
      : ActivityTotal.fromJson(
          json['recent_swim_totals'] as Map<String, dynamic>,
        ),
  biggestRideDistance: _biggestRideDistanceFromJson(
    json['biggest_ride_distance'],
  ),
  ytdSwimTotals: json['ytd_swim_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['ytd_swim_totals'] as Map<String, dynamic>),
  allSwimTotals: json['all_swim_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['all_swim_totals'] as Map<String, dynamic>),
  recentRideTotals: json['recent_ride_totals'] == null
      ? null
      : ActivityTotal.fromJson(
          json['recent_ride_totals'] as Map<String, dynamic>,
        ),
  biggestClimbElevationGain: _biggestClimbElevationGainFromJson(
    json['biggest_climb_elevation_gain'],
  ),
  ytdRideTotals: json['ytd_ride_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['ytd_ride_totals'] as Map<String, dynamic>),
  allRideTotals: json['all_ride_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['all_ride_totals'] as Map<String, dynamic>),
  ytdRunTotals: json['ytd_run_totals'] == null
      ? null
      : ActivityTotal.fromJson(json['ytd_run_totals'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActivityStatsToJson(ActivityStats instance) =>
    <String, dynamic>{
      'recent_run_totals': instance.recentRunTotals?.toJson(),
      'all_run_totals': instance.allRunTotals?.toJson(),
      'recent_swim_totals': instance.recentSwimTotals?.toJson(),
      'biggest_ride_distance': instance.biggestRideDistance,
      'ytd_swim_totals': instance.ytdSwimTotals?.toJson(),
      'all_swim_totals': instance.allSwimTotals?.toJson(),
      'recent_ride_totals': instance.recentRideTotals?.toJson(),
      'biggest_climb_elevation_gain': instance.biggestClimbElevationGain,
      'ytd_ride_totals': instance.ytdRideTotals?.toJson(),
      'all_ride_totals': instance.allRideTotals?.toJson(),
      'ytd_run_totals': instance.ytdRunTotals?.toJson(),
    };

ActivityTotal _$ActivityTotalFromJson(Map<String, dynamic> json) =>
    ActivityTotal(
      distance: (json['distance'] as num?)?.toDouble(),
      achievementCount: (json['achievement_count'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
      elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
      elevationGain: (json['elevation_gain'] as num?)?.toDouble(),
      movingTime: (json['moving_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActivityTotalToJson(ActivityTotal instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'achievement_count': instance.achievementCount,
      'count': instance.count,
      'elapsed_time': instance.elapsedTime,
      'elevation_gain': instance.elevationGain,
      'moving_time': instance.movingTime,
    };
