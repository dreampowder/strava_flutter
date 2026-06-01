// To parse this JSON data, do
//
//     final stravaStats = stravaStatsFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_activity_stats.g.dart';

/// Preserves the legacy behavior of defaulting to `0` when the
/// biggest_ride_distance field is absent or null in the JSON payload.
double? _biggestRideDistanceFromJson(dynamic value) =>
    value?.toDouble() ?? 0;

/// Preserves the legacy behavior of defaulting to `0` when the
/// biggest_climb_elevation_gain field is absent or null in the JSON payload.
double? _biggestClimbElevationGainFromJson(dynamic value) =>
    value?.toDouble() ?? 0;

/// A set of rolled-up statistics and totals for an athlete.
@JsonSerializable()
class ActivityStats {
  ActivityStats({
    this.recentRunTotals,
    this.allRunTotals,
    this.recentSwimTotals,
    this.biggestRideDistance,
    this.ytdSwimTotals,
    this.allSwimTotals,
    this.recentRideTotals,
    this.biggestClimbElevationGain,
    this.ytdRideTotals,
    this.allRideTotals,
    this.ytdRunTotals,
  });

  /// The recent (last 4 weeks) run stats for the athlete.
  @JsonKey(name: "recent_run_totals")
  ActivityTotal? recentRunTotals;

  /// The all time run stats for the athlete.
  @JsonKey(name: "all_run_totals")
  ActivityTotal? allRunTotals;

  /// The recent (last 4 weeks) swim stats for the athlete.
  @JsonKey(name: "recent_swim_totals")
  ActivityTotal? recentSwimTotals;

  /// The longest distance ridden by the athlete.
  @JsonKey(name: "biggest_ride_distance", fromJson: _biggestRideDistanceFromJson)
  double? biggestRideDistance;

  /// The year to date swim stats for the athlete.
  @JsonKey(name: "ytd_swim_totals")
  ActivityTotal? ytdSwimTotals;

  /// The all time swim stats for the athlete.
  @JsonKey(name: "all_swim_totals")
  ActivityTotal? allSwimTotals;

  /// The recent (last 4 weeks) ride stats for the athlete.
  @JsonKey(name: "recent_ride_totals")
  ActivityTotal? recentRideTotals;

  /// The highest climb ridden by the athlete.
  @JsonKey(
      name: "biggest_climb_elevation_gain",
      fromJson: _biggestClimbElevationGainFromJson)
  double? biggestClimbElevationGain;

  /// The year to date ride stats for the athlete.
  @JsonKey(name: "ytd_ride_totals")
  ActivityTotal? ytdRideTotals;

  /// The all time ride stats for the athlete.
  @JsonKey(name: "all_ride_totals")
  ActivityTotal? allRideTotals;

  /// The year to date run stats for the athlete.
  @JsonKey(name: "ytd_run_totals")
  ActivityTotal? ytdRunTotals;

  factory ActivityStats.fromRawJson(String str) =>
      ActivityStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityStats.fromJson(Map<String, dynamic> json) =>
      _$ActivityStatsFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityStatsToJson(this);
}

/// A roll-up of metrics pertaining to a set of activities. Values are in
/// seconds and meters.
@JsonSerializable()
class ActivityTotal {
  ActivityTotal({
    this.distance,
    this.achievementCount,
    this.count,
    this.elapsedTime,
    this.elevationGain,
    this.movingTime,
  });

  /// The total distance covered by the considered activities.
  @JsonKey(name: "distance")
  double? distance;

  /// The total number of achievements of the considered activities.
  @JsonKey(name: "achievement_count")
  int? achievementCount;

  /// The number of activities considered in this total.
  @JsonKey(name: "count")
  int? count;

  /// The total elapsed time of the considered activities.
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;

  /// The total elevation gain of the considered activities.
  @JsonKey(name: "elevation_gain")
  double? elevationGain;

  /// The total moving time of the considered activities.
  @JsonKey(name: "moving_time")
  int? movingTime;

  factory ActivityTotal.fromRawJson(String str) =>
      ActivityTotal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityTotal.fromJson(Map<String, dynamic> json) =>
      _$ActivityTotalFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityTotalToJson(this);
}
