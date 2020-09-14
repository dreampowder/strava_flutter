import 'fault.dart';

class SummarySegment {
  Fault fault;
  int id;
  int resourceState;
  String name;
  String activityType;
  double distance;
  double averageGrade;
  double maximumGrade;
  double elevationHigh;
  double elevationLow;
  List<double> startLatlng;
  List<double> endLatlng;
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLongitude;
  int climbCategory;
  String city;
  String state;
  String country;
  bool private;
  bool hazardous;
  bool starred;
  String createdAt;
  String updatedAt;
  double totalElevationGain;
  Carte map;
  int effortCount;
  int athleteCount;
  int starCount;
  AthleteSegmentStats athleteSegmentStats;

  SummarySegment(
      {Fault fault,
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
      this.createdAt,
      this.updatedAt,
      this.totalElevationGain,
      this.map,
      this.effortCount,
      this.athleteCount,
      this.starCount,
      this.athleteSegmentStats});

  SummarySegment.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalElevationGain = json['total_elevation_gain'];
    map = json['map'] != null ? new Carte.fromJson(json['map']) : null;
    effortCount = json['effort_count'];
    athleteCount = json['athlete_count'];
    starCount = json['star_count'];
    athleteSegmentStats = json['athlete_segment_stats'] != null
        ? new AthleteSegmentStats.fromJson(json['athlete_segment_stats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_elevation_gain'] = this.totalElevationGain;
    if (this.map != null) {
      data['map'] = this.map.toJson();
    }
    data['effort_count'] = this.effortCount;
    data['athlete_count'] = this.athleteCount;
    data['star_count'] = this.starCount;
    if (this.athleteSegmentStats != null) {
      data['athlete_segment_stats'] = this.athleteSegmentStats.toJson();
    }
    return data;
  }
}

class Carte {
  String id;
  String polyline;
  int resourceState;

  Carte({this.id, this.polyline, this.resourceState});

  Carte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    polyline = json['polyline'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['polyline'] = this.polyline;
    data['resource_state'] = this.resourceState;
    return data;
  }
}

class AthleteSegmentStats {
  int prElapsedTime;
  String prDate;
  int effortCount;

  AthleteSegmentStats({this.prElapsedTime, this.prDate, this.effortCount});

  AthleteSegmentStats.fromJson(Map<String, dynamic> json) {
    prElapsedTime = json['pr_elapsed_time'];
    prDate = json['pr_date'];
    effortCount = json['effort_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pr_elapsed_time'] = this.prElapsedTime;
    data['pr_date'] = this.prDate;
    data['effort_count'] = this.effortCount;
    return data;
  }
}

class DetailedSegment {
  Fault fault;
  int id;
  int resourceState;
  String name;
  String activityType;
  double distance;
  double averageGrade;
  double maximumGrade;
  double elevationHigh;
  double elevationLow;
  List<double> startLatlng;
  List<double> endLatlng;
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLongitude;
  int climbCategory;
  String city;
  String state;
  String country;
  bool private;
  bool hazardous;
  bool starred;
  String createdAt;
  String updatedAt;
  double totalElevationGain;
  Carte map;
  int effortCount;
  int athleteCount;
  int starCount;
  AthleteSegmentStats athleteSegmentStats;

  DetailedSegment(
      {Fault fault,
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
      this.createdAt,
      this.updatedAt,
      this.totalElevationGain,
      this.map,
      this.effortCount,
      this.athleteCount,
      this.starCount,
      this.athleteSegmentStats});

  DetailedSegment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activityType = json['activity_type'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    elevationHigh = json['elevation_high'];
    elevationLow = json['elevation_low'];
    startLatlng = json['start_latlng'].cast<double>();
    endLatlng = json['end_latlng'].cast<double>();
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalElevationGain = json['total_elevation_gain'];
    map = json['map'] != null ? new Carte.fromJson(json['map']) : null;
    effortCount = json['effort_count'];
    athleteCount = json['athlete_count'];
    starCount = json['star_count'];
    athleteSegmentStats = json['athlete_segment_stats'] != null
        ? new AthleteSegmentStats.fromJson(json['athlete_segment_stats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_elevation_gain'] = this.totalElevationGain;
    if (this.map != null) {
      data['map'] = this.map.toJson();
    }
    data['effort_count'] = this.effortCount;
    data['athlete_count'] = this.athleteCount;
    data['star_count'] = this.starCount;
    if (this.athleteSegmentStats != null) {
      data['athlete_segment_stats'] = this.athleteSegmentStats.toJson();
    }
    return data;
  }
}

class SegmentsList {
  Fault fault;
  final List<SummarySegment> segments;

  SegmentsList({this.segments});

  factory SegmentsList.fromJson(List<dynamic> parsedJson) {
    List<SummarySegment> segments = List<SummarySegment>();
    segments = parsedJson.map((i) => SummarySegment.fromJson(i)).toList();

    return SegmentsList(segments: segments);
  }
}

class SegmentLeaderboard {
  Fault fault;
  int effortCount;
  int entryCount;
  String komType;
  List<Entries> entries;

  SegmentLeaderboard(
      {this.fault,
      this.effortCount,
      this.entryCount,
      this.komType,
      this.entries});

  SegmentLeaderboard.fromJson(Map<String, dynamic> json) {
    effortCount = json['effort_count'];
    entryCount = json['entry_count'];
    komType = json['kom_type'];
    if (json['entries'] != null) {
      entries = new List<Entries>();
      json['entries'].forEach((v) {
        entries.add(new Entries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['effort_count'] = this.effortCount;
    data['entry_count'] = this.entryCount;
    data['kom_type'] = this.komType;
    if (this.entries != null) {
      data['entries'] = this.entries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entries {
  String athleteName;
  int elapsedTime;
  int movingTime;
  String startDate;
  String startDateLocal;
  int rank;

  Entries(
      {this.athleteName,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.rank});

  Entries.fromJson(Map<String, dynamic> json) {
    athleteName = json['athlete_name'];
    elapsedTime = json['elapsed_time'];
    movingTime = json['moving_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['athlete_name'] = this.athleteName;
    data['elapsed_time'] = this.elapsedTime;
    data['moving_time'] = this.movingTime;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['rank'] = this.rank;
    return data;
  }
}
