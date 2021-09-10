import 'package:strava_flutter/models/athlete.dart';

import 'fault.dart';

class DetailedSegmentEffort {
  Fault? fault;
  int? id;
  int? resourceState;
  String? name;
  ActivityEffort? activity;
  Athlete? athlete;
  int? elapsedTime;
  String? startDate;
  String? startDateLocal;
  double? distance;
  int? movingTime;
  int? startIndex;
  int? endIndex;
  bool? deviceWatts;
  double? averageWatts;
  SegmentEffort? segment;

  int? komRank;
  int? prRank;
  List<dynamic>? achievements; // could be a list of something

  DetailedSegmentEffort({
    Fault? fault,
    this.id,
    this.resourceState,
    this.name,
    this.activity,
    this.athlete,
    this.elapsedTime,
    this.startDate,
    this.startDateLocal,
    this.distance,
    this.movingTime,
    this.startIndex,
    this.endIndex,
    this.deviceWatts,
    this.averageWatts,
    this.segment,
    this.komRank,
    this.prRank,
    this.achievements,
  });

  DetailedSegmentEffort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activity = ActivityEffort.fromJson(json['activity']);
    athlete = Athlete.fromJson(json['athlete']);
    elapsedTime = json['elapsed_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    distance = json['distance'];
    movingTime = json['moving_time'];
    startIndex = json['start_index'];
    endIndex = json['end_index'];
    deviceWatts = json['device_watts'];
    averageWatts = json['average_watts'];
    segment = SegmentEffort.fromJson(json['segment']);
    komRank = json['kom_rank'];
    prRank = json['pr_rank'];
    achievements = json['achievements'] ?? '0' as List<dynamic>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    data['activity_type'] = this.activity;
    data['athlete'] = this.athlete;
    data['elapsed_time'] = this.elapsedTime;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['distance'] = this.distance;

    data['moving_time'] = this.movingTime;
    data['start_index'] = this.startIndex;
    data['end_index'] = this.endIndex;
    data['device_watts'] = this.deviceWatts;
    data['average_watts'] = this.averageWatts;
    data['segment'] = this.segment;
    data['kom_rank'] = this.komRank;
    data['pr_rank'] = this.prRank;
    data['achievements'] = this.averageWatts;
    return data;
  }
}

class SegmentEffort {
  Fault? fault;
  int? id;
  int? resourceState;
  String? name;
  String? activityType;
  double? distance;
  double? averageGrade;
  double? maximumGrade;
  double? elevationHigh;
  double? elevationLow;
  List<double>? startLatlng;
  List<double>? endLatlng;
  double? startLatitude;
  double? startLongitude;
  double? endLatitude;
  double? endLongitude;
  int? climbCategory;
  String? city;
  String? state;
  String? country;
  bool? private;
  bool? hazardous;
  bool? starred;

  SegmentEffort({
    Fault? fault,
    this.id,
    this.resourceState,
    this.name,
    this.activityType,
    this.distance,
    this.averageGrade,
    this.maximumGrade,
    this.elevationHigh,
    this.elevationLow,
    this.startLatlng,
    this.endLatlng,
    this.startLatitude,
    this.startLongitude,
    this.endLatitude,
    this.endLongitude,
    this.climbCategory,
    this.city,
    this.state,
    this.country,
    this.private,
    this.hazardous,
    this.starred,
  });

  SegmentEffort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activityType = json['activity_type'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    elevationHigh = json['elevation_high'];
    elevationLow = json['elevation_low'];
    startLatlng = json['start_latlng']?.cast<double>();
    endLatlng = json['end_latlng']?.cast<double>();
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    climbCategory = json['climb_category'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    private = json['private'];
    hazardous = json['hazardous'];
    starred = json['starred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    data['activity_type'] = this.activityType;
    data['distance'] = this.distance;
    data['average_grade'] = this.averageGrade;
    data['maximum_grade'] = this.maximumGrade;
    data['elevation_high'] = this.elevationHigh;
    data['elevation_low'] = this.elevationLow;
    data['start_latlng'] = this.startLatlng;
    data['end_latlng'] = this.endLatlng;
    data['start_latitude'] = this.startLatitude;
    data['start_longitude'] = this.startLongitude;
    data['end_latitude'] = this.endLatitude;
    data['end_longitude'] = this.endLongitude;
    data['climb_category'] = this.climbCategory;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['private'] = this.private;
    data['hazardous'] = this.hazardous;
    data['starred'] = this.starred;

    return data;
  }
}

class ActivityEffort {
  int? id;
  int? resourceState;

  ActivityEffort({
    this.id,
    this.resourceState,
  });

  ActivityEffort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;

    return data;
  }
}

class AthleteEffort {
  int? id;
  int? resourceState;

  AthleteEffort({
    this.id,
    this.resourceState,
  });

  AthleteEffort.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;

    return data;
  }
}
