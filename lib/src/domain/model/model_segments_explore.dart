import 'package:json_annotation/json_annotation.dart';

part 'model_segments_explore.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the latlng field is absent from the JSON payload.
List<double>? _latLngFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

// segments : [{"id":229781,"resource_state":2,"name":"Hawk Hill","climb_category":1,"climb_category_desc":"4","avg_grade":5.7,"start_latlng":[37.8331119,-122.4834356],"end_latlng":[37.8280722,-122.4981393],"elev_difference":152.8,"distance":2684.8,"points":"}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@","starred":false}]
@JsonSerializable()
class ExplorerResponse {
  /// The set of segments matching an explorer request.
  @JsonKey(name: "segments", includeIfNull: false)
  List<ExplorerSegment>? segments;

  ExplorerResponse({this.segments});

  factory ExplorerResponse.fromJson(Map<String, dynamic> json) =>
      _$ExplorerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExplorerResponseToJson(this);
}

// id : 229781
// resource_state : 2
// name : "Hawk Hill"
// climb_category : 1
// climb_category_desc : "4"
// avg_grade : 5.7
// start_latlng : [37.8331119,-122.4834356]
// end_latlng : [37.8280722,-122.4981393]
// elev_difference : 152.8
// distance : 2684.8
// points : "}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@"
// starred : false
@JsonSerializable()
class ExplorerSegment {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "resource_state")
  int? resourceState;
  @JsonKey(name: "name")
  String? name;

  /// The category of the climb [0, 5]. Higher is harder ie. 5 is
  /// `Hors catégorie`, 0 is uncategorized in climb_category. If climb_category
  /// = 5, climb_category_desc = HC. If climb_category = 2, climb_category_desc
  /// = 3. (From Strava's reference documentation...)
  @JsonKey(name: "climb_category")
  int? climbCategory;

  /// The description for the category of the climb May take one of the
  /// following values: `NC`, `4`, `3`, `2`, `1`, `HC`
  @JsonKey(name: "climb_category_desc")
  String? climbCategoryDesc;

  /// The segment's average grade, in percents.
  @JsonKey(name: "avg_grade")
  double? avgGrade;
  @JsonKey(name: "start_latlng", fromJson: _latLngFromJson)
  List<double>? startLatlng;
  @JsonKey(name: "end_latlng", fromJson: _latLngFromJson)
  List<double>? endLatlng;

  /// The segments's evelation difference, in meters.
  @JsonKey(name: "elev_difference")
  double? elevDifference;

  /// The segment's distance, in meters.
  @JsonKey(name: "distance")
  double? distance;
  @JsonKey(name: "points")
  String? points;
  @JsonKey(name: "starred")
  bool? starred;

  ExplorerSegment(
      {this.id,
      this.resourceState,
      this.name,
      this.climbCategory,
      this.climbCategoryDesc,
      this.avgGrade,
      this.startLatlng,
      this.endLatlng,
      this.elevDifference,
      this.distance,
      this.points,
      this.starred});

  factory ExplorerSegment.fromJson(Map<String, dynamic> json) =>
      _$ExplorerSegmentFromJson(json);

  Map<String, dynamic> toJson() => _$ExplorerSegmentToJson(this);
}
