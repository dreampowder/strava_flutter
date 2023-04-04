// To parse this JSON data, do
//
//     final stravaStats = stravaStatsFromJson(jsonString);

import 'dart:convert';

/// A set of rolled-up statistics and totals for an athlete.
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
  ActivityTotal? recentRunTotals;

  /// The all time run stats for the athlete.
  ActivityTotal? allRunTotals;

  /// The recent (last 4 weeks) swim stats for the athlete.
  ActivityTotal? recentSwimTotals;

  /// The longest distance ridden by the athlete.
  double? biggestRideDistance;

  /// The year to date swim stats for the athlete.
  ActivityTotal? ytdSwimTotals;

  /// The all time swim stats for the athlete.
  ActivityTotal? allSwimTotals;

  /// The recent (last 4 weeks) ride stats for the athlete.
  ActivityTotal? recentRideTotals;

  /// The highest climb ridden by the athlete.
  double? biggestClimbElevationGain;

  /// The year to date ride stats for the athlete.
  ActivityTotal? ytdRideTotals;

  /// The all time ride stats for the athlete.
  ActivityTotal? allRideTotals;

  /// The year to date run stats for the athlete.
  ActivityTotal? ytdRunTotals;

  factory ActivityStats.fromRawJson(String str) =>
      ActivityStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityStats.fromJson(Map<String, dynamic> json) => ActivityStats(
        recentRunTotals: ActivityTotal.fromJson(json["recent_run_totals"]),
        allRunTotals: ActivityTotal.fromJson(json["all_run_totals"]),
        recentSwimTotals: ActivityTotal.fromJson(json["recent_swim_totals"]),
        biggestRideDistance: json["biggest_ride_distance"]?.toDouble() ?? 0,
        ytdSwimTotals: ActivityTotal.fromJson(json["ytd_swim_totals"]),
        allSwimTotals: ActivityTotal.fromJson(json["all_swim_totals"]),
        recentRideTotals: ActivityTotal.fromJson(json["recent_ride_totals"]),
        biggestClimbElevationGain:
            json["biggest_climb_elevation_gain"]?.toDouble() ?? 0,
        ytdRideTotals: ActivityTotal.fromJson(json["ytd_ride_totals"]),
        allRideTotals: ActivityTotal.fromJson(json["all_ride_totals"]),
        ytdRunTotals: ActivityTotal.fromJson(json["ytd_run_totals"]),
      );

  Map<String, dynamic> toJson() => {
        "recent_run_totals": recentRunTotals?.toJson(),
        "all_run_totals": allRunTotals?.toJson(),
        "recent_swim_totals": recentSwimTotals?.toJson(),
        "biggest_ride_distance": biggestRideDistance,
        "ytd_swim_totals": ytdSwimTotals?.toJson(),
        "all_swim_totals": allSwimTotals?.toJson(),
        "recent_ride_totals": recentRideTotals?.toJson(),
        "biggest_climb_elevation_gain": biggestClimbElevationGain,
        "ytd_ride_totals": ytdRideTotals?.toJson(),
        "all_ride_totals": allRideTotals?.toJson(),
        "ytd_run_totals": ytdRunTotals?.toJson(),
      };
}

/// A roll-up of metrics pertaining to a set of activities. Values are in
/// seconds and meters.
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
  double? distance;

  /// The total number of achievements of the considered activities.
  int? achievementCount;

  /// The number of activities considered in this total.
  int? count;

  /// The total elapsed time of the considered activities.
  int? elapsedTime;

  /// The total elevation gain of the considered activities.
  double? elevationGain;

  /// The total moving time of the considered activities.
  int? movingTime;

  factory ActivityTotal.fromRawJson(String str) =>
      ActivityTotal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityTotal.fromJson(Map<String, dynamic> json) => ActivityTotal(
        distance: json["distance"].toDouble(),
        achievementCount: json["achievement_count"],
        count: json["count"],
        elapsedTime: json["elapsed_time"],
        elevationGain: json["elevation_gain"].toDouble(),
        movingTime: json["moving_time"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "achievement_count": achievementCount,
        "count": count,
        "elapsed_time": elapsedTime,
        "elevation_gain": elevationGain,
        "moving_time": movingTime,
      };
}
