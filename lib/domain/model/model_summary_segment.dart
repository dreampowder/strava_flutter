/// country : "aeiou"
/// private : true
/// distance : 3.6160767
/// average_grade : 2.027123
/// maximum_grade : 4.145608
/// climb_category : 1
/// city : "aeiou"
/// elevation_high : 7.386282
/// athlete_pr_effort : {"distance":1.1730742,"start_date_local":"2000-01-23T04:56:07.000+00:00","activity_id":6,"elapsed_time":7,"is_kom":true,"id":1,"start_date":"2000-01-23T04:56:07.000+00:00"}
/// athlete_segment_stats : {"pr_elapsed_time":5,"pr_date":"2000-01-23T04:56:07.000+00:00","effort_count":9,"pr_activity_id":4}
/// start_latlng : ""
/// elevation_low : 1.2315135
/// end_latlng : ""
/// activity_type : "Ride"
/// name : "aeiou"
/// id : 9
/// state : "aeiou"

class SummarySegment {
  String? country;
  bool? private;
  double? distance;
  double? averageGrade;
  double? maximumGrade;
  int? climbCategory;
  String? city;
  double? elevationHigh;
  SummarySegmentEffort? athletePrEffort;
  SummaryPRSegmentEffort? athleteSegmentStats;
  String? startLatlng;
  double? elevationLow;
  String? endLatlng;
  String? activityType;
  String? name;
  int? id;
  String? state;

  SummarySegment({
    this.country,
    this.private,
    this.distance,
    this.averageGrade,
    this.maximumGrade,
    this.climbCategory,
    this.city,
    this.elevationHigh,
    this.athletePrEffort,
    this.athleteSegmentStats,
    this.startLatlng,
    this.elevationLow,
    this.endLatlng,
    this.activityType,
    this.name,
    this.id,
    this.state});

  SummarySegment.fromJson(dynamic json) {
    country = json['country'];
    private = json['private'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    climbCategory = json['climb_category'];
    city = json['city'];
    elevationHigh = json['elevation_high'];
    athletePrEffort = json['athlete_pr_effort'] != null ? SummarySegmentEffort.fromJson(json['athletePrEffort']) : null;
    athleteSegmentStats = json['athlete_segment_stats'] != null ? SummaryPRSegmentEffort.fromJson(json['athleteSegmentStats']) : null;
    startLatlng = json['start_latlng'];
    elevationLow = json['elevation_low'];
    endLatlng = json['end_latlng'];
    activityType = json['activity_type'];
    name = json['name'];
    id = json['id'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['country'] = country;
    map['private'] = private;
    map['distance'] = distance;
    map['average_grade'] = averageGrade;
    map['maximum_grade'] = maximumGrade;
    map['climb_category'] = climbCategory;
    map['city'] = city;
    map['elevation_high'] = elevationHigh;
    if (athletePrEffort != null) {
      map['athlete_pr_effort'] = athletePrEffort?.toJson();
    }
    if (athleteSegmentStats != null) {
      map['athlete_segment_stats'] = athleteSegmentStats?.toJson();
    }
    map['start_latlng'] = startLatlng;
    map['elevation_low'] = elevationLow;
    map['end_latlng'] = endLatlng;
    map['activity_type'] = activityType;
    map['name'] = name;
    map['id'] = id;
    map['state'] = state;
    return map;
  }

}

/// pr_elapsed_time : 5
/// pr_date : "2000-01-23T04:56:07.000+00:00"
/// effort_count : 9
/// pr_activity_id : 4

class SummaryPRSegmentEffort {
  int? prElapsedTime;
  String? prDate;
  int? effortCount;
  int? prActivityId;

  SummaryPRSegmentEffort({
    this.prElapsedTime,
    this.prDate,
    this.effortCount,
    this.prActivityId});

  SummaryPRSegmentEffort.fromJson(dynamic json) {
    prElapsedTime = json['pr_elapsed_time'];
    prDate = json['pr_date'];
    effortCount = json['effort_count'];
    prActivityId = json['pr_activity_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pr_elapsed_time'] = prElapsedTime;
    map['pr_date'] = prDate;
    map['effort_count'] = effortCount;
    map['pr_activity_id'] = prActivityId;
    return map;
  }

}

/// distance : 1.1730742
/// start_date_local : "2000-01-23T04:56:07.000+00:00"
/// activity_id : 6
/// elapsed_time : 7
/// is_kom : true
/// id : 1
/// start_date : "2000-01-23T04:56:07.000+00:00"

class SummarySegmentEffort {
  double? distance;
  String? startDateLocal;
  int? activityId;
  int? elapsedTime;
  bool? isKom;
  int? id;
  String? startDate;

  SummarySegmentEffort({
    this.distance,
    this.startDateLocal,
    this.activityId,
    this.elapsedTime,
    this.isKom,
    this.id,
    this.startDate});

  SummarySegmentEffort.fromJson(dynamic json) {
    distance = json['distance'];
    startDateLocal = json['start_date_local'];
    activityId = json['activity_id'];
    elapsedTime = json['elapsed_time'];
    isKom = json['is_kom'];
    id = json['id'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['distance'] = distance;
    map['start_date_local'] = startDateLocal;
    map['activity_id'] = activityId;
    map['elapsed_time'] = elapsedTime;
    map['is_kom'] = isKom;
    map['id'] = id;
    map['start_date'] = startDate;
    return map;
  }

}