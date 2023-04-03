// To parse this JSON data, do
//
//     final stravaStats = stravaStatsFromJson(jsonString);

import 'dart:convert';

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

  ActivityTotal? recentRunTotals;
  ActivityTotal? allRunTotals;
  ActivityTotal? recentSwimTotals;
  double? biggestRideDistance;
  ActivityTotal? ytdSwimTotals;
  ActivityTotal? allSwimTotals;
  ActivityTotal? recentRideTotals;
  double? biggestClimbElevationGain;
  ActivityTotal? ytdRideTotals;
  ActivityTotal? allRideTotals;
  ActivityTotal? ytdRunTotals;

  factory ActivityStats.fromRawJson(String str) => ActivityStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActivityStats.fromJson(Map<String, dynamic> json) => ActivityStats(
    recentRunTotals: ActivityTotal.fromJson(json["recent_run_totals"]),
    allRunTotals: ActivityTotal.fromJson(json["all_run_totals"]),
    recentSwimTotals: ActivityTotal.fromJson(json["recent_swim_totals"]),
    biggestRideDistance: json["biggest_ride_distance"]?.toDouble() ?? 0,
    ytdSwimTotals: ActivityTotal.fromJson(json["ytd_swim_totals"]),
    allSwimTotals: ActivityTotal.fromJson(json["all_swim_totals"]),
    recentRideTotals: ActivityTotal.fromJson(json["recent_ride_totals"]),
    biggestClimbElevationGain: json["biggest_climb_elevation_gain"]?.toDouble() ?? 0,
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

class ActivityTotal {
  ActivityTotal({
    this.distance,
    this.achievementCount,
    this.count,
    this.elapsedTime,
    this.elevationGain,
    this.movingTime,
  });

  double? distance;
  int? achievementCount;
  int? count;
  int? elapsedTime;
  double? elevationGain;
  int? movingTime;

  factory ActivityTotal.fromRawJson(String str) => ActivityTotal.fromJson(json.decode(str));

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
