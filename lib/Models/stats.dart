// Stats

import 'fault.dart';

class Stats {
  Fault fault;
  StatsTotals recentRunTotals;
  ActivityTotals allRunTotals;
  StatsTotals recentSwimTotals;
  double biggestRideDistance;
  ActivityTotals ytdSwimTotals;
  ActivityTotals allSwimTotals;
  StatsTotals recentRideTotals;
  double biggestClimbElevationGain;
  ActivityTotals ytdRideTotals;
  ActivityTotals allRideTotals;
  ActivityTotals ytdRunTotals;

  Stats(
      {Fault fault,
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
      this.ytdRunTotals})
      : fault = Fault(88, '');

  Stats.fromJson(Map<String, dynamic> json) {
    recentRunTotals = json['recent_run_totals'] != null
        ? StatsTotals.fromJson(json['recent_run_totals'])
        : null;
    allRunTotals = json['all_run_totals'] != null
        ? ActivityTotals.fromJson(json['all_run_totals'])
        : null;
    recentSwimTotals = json['recent_swim_totals'] != null
        ? StatsTotals.fromJson(json['recent_swim_totals'])
        : null;
    biggestRideDistance = json['biggest_ride_distance'];
    ytdSwimTotals = json['ytd_swim_totals'] != null
        ? ActivityTotals.fromJson(json['ytd_swim_totals'])
        : null;

    allSwimTotals = json['all_swim_totals'] != null
        ? ActivityTotals.fromJson(json['all_swim_totals'])
        : null;

    recentRideTotals = json['recent_ride_totals'] != null
        ? StatsTotals.fromJson(json['recent_ride_totals'])
        : null;

    biggestClimbElevationGain = json['biggest_climb_elevation_gain'];
    ytdRideTotals = json['ytd_ride_totals'] != null
        ? ActivityTotals.fromJson(json['ytd_ride_totals'])
        : null;

    allRideTotals = json['all_ride_totals'] != null
        ? ActivityTotals.fromJson(json['all_ride_totals'])
        : null;
    ytdRunTotals = json['ytd_run_totals'] != null
        ? ActivityTotals.fromJson(json['ytd_run_totals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recent_run_totals'] = this.recentRunTotals;
    data['all_run_totals'] = this.allRunTotals;
    data['recent_swim_totals'] = this.recentSwimTotals;
    data['biggest_ride_distance'] = this.biggestRideDistance;
    data['ytd_swim_totals'] = this.ytdSwimTotals;
    data['all_swim_totals'] = this.allSwimTotals;
    if (this.recentRideTotals != null) {
      data['recent_ride_totals'] = this.recentRideTotals.toJson();
    }
    data['biggest_climb_elevation_gain'] = this.biggestClimbElevationGain;
    data['ytd_ride_totals'] = this.ytdRideTotals;
    data['all_ride_totals'] = this.allRideTotals;
    data['ytd_run_totals'] = this.ytdRunTotals;
    return data;
  }
}

class StatsTotals {
  double distance;
  int achievementCount;
  int count;
  int elapsedTime;
  double elevationGain;
  int movingTime;

  StatsTotals(
      {this.distance,
      this.achievementCount,
      this.count,
      this.elapsedTime,
      this.elevationGain,
      this.movingTime});

  StatsTotals.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    achievementCount = json['achievement_count'];
    count = json['count'];
    elapsedTime = json['elapsed_time'];
    elevationGain = json['elevation_gain'];
    movingTime = json['moving_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['distance'] = this.distance;
    data['achievement_count'] = this.achievementCount;
    data['count'] = this.count;
    data['elapsed_time'] = this.elapsedTime;
    data['elevation_gain'] = this.elevationGain;
    data['moving_time'] = this.movingTime;
    return data;
  }
}

class ActivityTotals {
  int distance;
  int achievementCount;
  int count;
  int elapsedTime;
  int elevationGain;
  int movingTime;

  ActivityTotals(
      {this.distance,
      this.achievementCount,
      this.count,
      this.elapsedTime,
      this.elevationGain,
      this.movingTime});

  ActivityTotals.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    achievementCount = json['achievement_count'];
    count = json['count'];
    elapsedTime = json['elapsed_time'];
    elevationGain = json['elevation_gain'];
    movingTime = json['moving_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['achievement_count'] = this.achievementCount;
    data['count'] = this.count;
    data['elapsed_time'] = this.elapsedTime;
    data['elevation_gain'] = this.elevationGain;
    data['moving_time'] = this.movingTime;
    return data;
  }
}
