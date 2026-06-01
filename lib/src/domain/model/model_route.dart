import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_detailed_activity.dart';
import 'package:strava_client/src/domain/model/model_summary_athlete.dart';
import 'package:strava_client/src/domain/model/model_summary_segment.dart';

part 'model_route.g.dart';

// private : true
// distance : 0.8008282
// athlete : ""
// description : "aeiou"
// created_at : "2000-01-23T04:56:07.000+00:00"
// elevation_gain : 6.0274563
// type : 5
// estimated_moving_time : 7
// segments : [{"country":"aeiou","private":true,"distance":3.6160767,"average_grade":2.027123,"maximum_grade":4.145608,"climb_category":1,"city":"aeiou","elevation_high":7.386282,"athlete_pr_effort":{"distance":1.1730742,"start_date_local":"2000-01-23T04:56:07.000+00:00","activity_id":6,"elapsed_time":7,"is_kom":true,"id":1,"start_date":"2000-01-23T04:56:07.000+00:00"},"athlete_segment_stats":{"pr_elapsed_time":5,"pr_date":"2000-01-23T04:56:07.000+00:00","effort_count":9,"pr_activity_id":4},"start_latlng":"","elevation_low":1.2315135,"end_latlng":"","activity_type":"Ride","name":"aeiou","id":9,"state":"aeiou"}]
// starred : true
// updated_at : "2000-01-23T04:56:07.000+00:00"
// sub_type : 2
// id_str : "aeiou"
// name : "aeiou"
// id : 1
// map : {"summary_polyline":"aeiou","id":"aeiou","polyline":"aeiou"}
// timestamp : 5
@JsonSerializable()
class Route {
  @JsonKey(name: "private")
  bool? private;

  /// The route's distance, in meters.
  @JsonKey(name: "distance")
  double? distance;

  @JsonKey(name: "athlete")
  SummaryAthlete? athlete;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "elevation_gain")
  double? elevationGain;

  /// This route's type (1 for ride, 2 for runs).
  @JsonKey(name: "type")
  int? type;

  /// Estimated time in seconds for the authenticated athlete to complete route.
  @JsonKey(name: "estimated_moving_time")
  int? estimatedMovingTime;

  @JsonKey(name: "segments", includeIfNull: false)
  List<SummarySegment>? segments;

  @JsonKey(name: "starred")
  bool? starred;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  /// This route's sub-type (1 for `road`, 2 for `mountain bike`, 3 for `cross`,
  /// 4 for `trail`, 5 for `mixed`).
  @JsonKey(name: "sub_type")
  int? subType;

  @JsonKey(name: "id_str")
  String? idStr;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "map")
  PolyLineMap? map;

  @JsonKey(name: "timestamp")
  int? timestamp;

  /// The custom waypoints along this route.
  @JsonKey(name: "waypoints", includeIfNull: false)
  List<Waypoint>? waypoints;

  Route(
      {this.private,
      this.distance,
      this.athlete,
      this.description,
      this.createdAt,
      this.elevationGain,
      this.type,
      this.estimatedMovingTime,
      this.segments,
      this.starred,
      this.updatedAt,
      this.subType,
      this.idStr,
      this.name,
      this.id,
      this.map,
      this.timestamp,
      this.waypoints});

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}

/// A custom waypoint along a [Route].
@JsonSerializable()
class Waypoint {
  /// The location along the route that the waypoint is closest to.
  @JsonKey(name: "latlng")
  List<double>? latlng;

  /// A location off of the route that the waypoint is (optionally) associated
  /// with.
  @JsonKey(name: "target_latlng")
  List<double>? targetLatlng;

  /// Categories that the waypoint belongs to.
  @JsonKey(name: "categories")
  List<String>? categories;

  /// A title for the waypoint.
  @JsonKey(name: "title")
  String? title;

  /// A description of the waypoint (optional).
  @JsonKey(name: "description")
  String? description;

  /// The number of meters along the route that the waypoint is located.
  @JsonKey(name: "distance_into_route")
  double? distanceIntoRoute;

  Waypoint(
      {this.latlng,
      this.targetLatlng,
      this.categories,
      this.title,
      this.description,
      this.distanceIntoRoute});

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);

  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
