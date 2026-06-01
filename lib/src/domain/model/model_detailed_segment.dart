import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_detailed_activity.dart';
import 'package:strava_client/src/domain/model/model_summary_segment.dart';

part 'model_detailed_segment.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the latlng field is absent from the JSON payload.
List<double>? _latLngFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

/// Preserves the legacy behavior of reading the athlete segment stats from the
/// `athleteSegmentStats` key (camelCase) on deserialization, even though it is
/// written back out under the `athlete_segment_stats` key.
Object? _athleteSegmentStatsReadValue(Map json, String key) =>
    json['athleteSegmentStats'];

// id : 229781
// resource_state : 3
// name : "Hawk Hill"
// activity_type : "Ride"
// distance : 2684.82
// average_grade : 5.7
// maximum_grade : 14.2
// elevation_high : 245.3
// elevation_low : 92.4
// start_latlng : [37.8331119,-122.4834356]
// end_latlng : [37.8280722,-122.4981393]
// climb_category : 1
// city : "San Francisco"
// state : "CA"
// country : "United States"
// private : false
// hazardous : false
// starred : false
// created_at : "2009-09-21T20:29:41Z"
// updated_at : "2018-02-15T09:04:18Z"
// total_elevation_gain : 155.733
// map : {"id":"s229781","polyline":"}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@","resource_state":3}
// effort_count : 309974
// athlete_count : 30623
// star_count : 2428
// athlete_segment_stats : {"pr_elapsed_time":553,"pr_date":"1993-04-03","effort_count":2}
@JsonSerializable()
class DetailedSegment {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "name")
  String? name;

  /// May take one of the following values: `Ride`, `Run`.
  @JsonKey(name: "activity_type")
  String? activityType;

  @JsonKey(name: "distance")
  double? distance;

  @JsonKey(name: "average_grade")
  double? averageGrade;

  @JsonKey(name: "maximum_grade")
  double? maximumGrade;

  @JsonKey(name: "elevation_high")
  double? elevationHigh;

  @JsonKey(name: "elevation_low")
  double? elevationLow;

  @JsonKey(name: "start_latlng", fromJson: _latLngFromJson)
  List<double>? startLatlng;

  @JsonKey(name: "end_latlng", fromJson: _latLngFromJson)
  List<double>? endLatlng;

  /// The category of the climb [0, 5]. Higher is harder ie. 5 is Hors
  /// catégorie, 0 is uncategorized in climb_category.
  @JsonKey(name: "climb_category")
  int? climbCategory;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "private")
  bool? private;

  @JsonKey(name: "hazardous")
  bool? hazardous;

  @JsonKey(name: "starred")
  bool? starred;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "total_elevation_gain")
  double? totalElevationGain;

  @JsonKey(name: "map", includeIfNull: false)
  PolyLineMap? map;

  @JsonKey(name: "effort_count")
  int? effortCount;

  @JsonKey(name: "athlete_count")
  int? athleteCount;

  @JsonKey(name: "star_count")
  int? starCount;

  @JsonKey(
    name: "athlete_segment_stats",
    includeIfNull: false,
    readValue: _athleteSegmentStatsReadValue,
  )
  SummaryPRSegmentEffort? athleteSegmentStats;

  /// The authenticated athlete's PR effort on this segment.
  @JsonKey(name: "athlete_pr_effort", includeIfNull: false)
  SummaryPRSegmentEffort? athletePrEffort;

  DetailedSegment({
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
    this.athleteSegmentStats,
    this.athletePrEffort,
  });

  factory DetailedSegment.fromJson(Map<String, dynamic> json) =>
      _$DetailedSegmentFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedSegmentToJson(this);
}
