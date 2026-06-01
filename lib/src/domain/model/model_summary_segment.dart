// country : "aeiou"
// private : true
// distance : 3.6160767
// average_grade : 2.027123
// maximum_grade : 4.145608
// climb_category : 1
// city : "aeiou"
// elevation_high : 7.386282
// athlete_pr_effort : {"distance":1.1730742,"start_date_local":"2000-01-23T04:56:07.000+00:00","activity_id":6,"elapsed_time":7,"is_kom":true,"id":1,"start_date":"2000-01-23T04:56:07.000+00:00"}
// athlete_segment_stats : {"pr_elapsed_time":5,"pr_date":"2000-01-23T04:56:07.000+00:00","effort_count":9,"pr_activity_id":4}
// start_latlng : ""
// elevation_low : 1.2315135
// end_latlng : ""
// activity_type : "Ride"
// name : "aeiou"
// id : 9
// state : "aeiou"
import 'package:json_annotation/json_annotation.dart';

part 'model_summary_segment.g.dart';

class SummarySegment {
  String? country;
  bool? private;

  /// The segment's distance, in meters.
  double? distance;

  /// The segment's average grade, in percents.
  double? averageGrade;

  /// The segments's maximum grade, in percents.
  double? maximumGrade;

  /// The category of the climb [0, 5]. Higher is harder ie. 5 is Hors
  /// catégorie, 0 is uncategorized in climb_category.
  int? climbCategory;
  String? city;

  /// The segments's highest elevation, in meters.
  double? elevationHigh;

  /// The segments's lowest elevation, in meters.
  double? elevationLow;
  SummarySegmentEffort? athletePrEffort;
  SummaryPRSegmentEffort? athleteSegmentStats;
  String? startLatlng;
  String? endLatlng;

  /// May take one of the following values: `Ride`, `Run`.
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
    this.state,
  });

  SummarySegment.fromJson(dynamic json) {
    country = json['country'];
    private = json['private'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    climbCategory = json['climb_category'];
    city = json['city'];
    elevationHigh = json['elevation_high'];
    athletePrEffort = json['athlete_pr_effort'] != null
        ? SummarySegmentEffort.fromJson(json['athletePrEffort'])
        : null;
    athleteSegmentStats = json['athlete_segment_stats'] != null
        ? SummaryPRSegmentEffort.fromJson(json['athleteSegmentStats'])
        : null;
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

// pr_elapsed_time : 5
// pr_date : "2000-01-23T04:56:07.000+00:00"
// effort_count : 9
// pr_activity_id : 4
@JsonSerializable()
class SummaryPRSegmentEffort {
  @JsonKey(name: "pr_elapsed_time")
  int? prElapsedTime;
  @JsonKey(name: "pr_date")
  String? prDate;
  @JsonKey(name: "effort_count")
  int? effortCount;
  @JsonKey(name: "pr_activity_id")
  int? prActivityId;

  SummaryPRSegmentEffort({
    this.prElapsedTime,
    this.prDate,
    this.effortCount,
    this.prActivityId,
  });

  factory SummaryPRSegmentEffort.fromJson(Map<String, dynamic> json) =>
      _$SummaryPRSegmentEffortFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryPRSegmentEffortToJson(this);
}

// distance : 1.1730742
// start_date_local : "2000-01-23T04:56:07.000+00:00"
// activity_id : 6
// elapsed_time : 7
// is_kom : true
// id : 1
// start_date : "2000-01-23T04:56:07.000+00:00"
@JsonSerializable()
class SummarySegmentEffort {
  @JsonKey(name: "distance")
  double? distance;
  @JsonKey(name: "start_date_local")
  String? startDateLocal;
  @JsonKey(name: "activity_id")
  int? activityId;
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;
  @JsonKey(name: "is_kom")
  bool? isKom;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "start_date")
  String? startDate;

  SummarySegmentEffort({
    this.distance,
    this.startDateLocal,
    this.activityId,
    this.elapsedTime,
    this.isKom,
    this.id,
    this.startDate,
  });

  factory SummarySegmentEffort.fromJson(Map<String, dynamic> json) =>
      _$SummarySegmentEffortFromJson(json);

  Map<String, dynamic> toJson() => _$SummarySegmentEffortToJson(this);
}
