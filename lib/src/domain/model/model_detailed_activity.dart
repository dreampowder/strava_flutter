import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_lap.dart';
import 'package:strava_client/src/domain/model/model_summary_gear.dart';

part 'model_detailed_activity.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the latlng field is absent from the JSON payload.
List<double>? _latLngFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

@JsonSerializable()
class DetailedActivity {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "external_id")
  String? externalId;

  @JsonKey(name: "upload_id")
  int? uploadId;

  @JsonKey(name: "athlete", includeIfNull: false)
  MetaAthlete? athlete;

  @JsonKey(name: "name")
  String? name;

  /// The activity's distance, in meters.
  @JsonKey(name: "distance")
  double? distance;

  /// The activity's moving time, in seconds.
  @JsonKey(name: "moving_time")
  int? movingTime;

  /// The activity's elapsed time, in seconds.
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;

  @JsonKey(name: "total_elevation_gain")
  double? totalElevationGain;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "start_date")
  String? startDate;

  @JsonKey(name: "start_date_local")
  String? startDateLocal;

  @JsonKey(name: "timezone")
  String? timezone;

  @JsonKey(name: "utc_offset")
  double? utcOffset;

  @JsonKey(name: "start_latlng", fromJson: _latLngFromJson)
  List<double>? startLatlng;

  @JsonKey(name: "end_latlng", fromJson: _latLngFromJson)
  List<double>? endLatlng;

  @JsonKey(name: "achievement_count")
  int? achievementCount;

  @JsonKey(name: "kudos_count")
  int? kudosCount;

  @JsonKey(name: "comment_count")
  int? commentCount;

  @JsonKey(name: "athlete_count")
  int? athleteCount;

  /// The number of Instagram photos for this activity.
  @JsonKey(name: "photo_count")
  int? photoCount;

  @JsonKey(name: "map", includeIfNull: false)
  PolyLineMap? map;

  @JsonKey(name: "trainer")
  bool? trainer;

  @JsonKey(name: "commute")
  bool? commute;

  @JsonKey(name: "manual")
  bool? manual;

  @JsonKey(name: "private")
  bool? private;

  @JsonKey(name: "flagged")
  bool? flagged;

  @JsonKey(name: "gear_id")
  String? gearId;

  @JsonKey(name: "from_accepted_tag")
  bool? fromAcceptedTag;

  /// The activity's average speed, in meters per second.
  @JsonKey(name: "average_speed")
  double? averageSpeed;

  /// The activity's max speed, in meters per second.
  @JsonKey(name: "max_speed")
  double? maxSpeed;

  @JsonKey(name: "average_cadence")
  double? averageCadence;

  @JsonKey(name: "average_temp")
  int? averageTemp;

  @JsonKey(name: "average_watts")
  double? averageWatts;

  @JsonKey(name: "weighted_average_watts")
  int? weightedAverageWatts;

  @JsonKey(name: "kilojoules")
  double? kilojoules;

  @JsonKey(name: "device_watts")
  bool? deviceWatts;

  @JsonKey(name: "has_heartrate")
  bool? hasHeartrate;

  @JsonKey(name: "max_watts")
  int? maxWatts;

  @JsonKey(name: "elev_high")
  double? elevHigh;

  @JsonKey(name: "elev_low")
  double? elevLow;

  @JsonKey(name: "pr_count")
  int? prCount;

  /// The number of Instagram and Strava photos for this activity.
  @JsonKey(name: "total_photo_count")
  int? totalPhotoCount;

  @JsonKey(name: "has_kudoed")
  bool? hasKudoed;

  @JsonKey(name: "workout_type")
  int? workoutType;

  @JsonKey(name: "suffer_score")
  num? sufferScore;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "calories")
  double? calories;

  @JsonKey(name: "segment_efforts", includeIfNull: false)
  List<DetailedSegmentEffort>? segmentEfforts;

  /// The splits of this activity in metric units (for runs).
  @JsonKey(name: "splits_metric", includeIfNull: false)
  List<SplitsMetric>? splitsMetric;

  @JsonKey(name: "laps", includeIfNull: false)
  List<Lap>? laps;

  @JsonKey(name: "gear", includeIfNull: false)
  SummaryGear? gear;

  @JsonKey(name: "partner_brand_tag")
  dynamic partnerBrandTag;

  @JsonKey(name: "photos", includeIfNull: false)
  PhotosSummary? photos;

  @JsonKey(name: "highlighted_kudosers", includeIfNull: false)
  List<HighlightedKudosers>? highlightedKudosers;

  @JsonKey(name: "device_name")
  String? deviceName;

  @JsonKey(name: "embed_token")
  String? embedToken;

  @JsonKey(name: "segment_leaderboard_opt_out")
  bool? segmentLeaderboardOptOut;

  @JsonKey(name: "leaderboard_opt_out")
  bool? leaderboardOptOut;

  DetailedActivity(
      {this.id,
      this.resourceState,
      this.externalId,
      this.uploadId,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.startDate,
      this.startDateLocal,
      this.timezone,
      this.utcOffset,
      this.startLatlng,
      this.endLatlng,
      this.achievementCount,
      this.kudosCount,
      this.commentCount,
      this.athleteCount,
      this.photoCount,
      this.map,
      this.trainer,
      this.commute,
      this.manual,
      this.private,
      this.flagged,
      this.gearId,
      this.fromAcceptedTag,
      this.averageSpeed,
      this.maxSpeed,
      this.averageCadence,
      this.averageTemp,
      this.averageWatts,
      this.weightedAverageWatts,
      this.kilojoules,
      this.deviceWatts,
      this.hasHeartrate,
      this.maxWatts,
      this.elevHigh,
      this.elevLow,
      this.prCount,
      this.totalPhotoCount,
      this.hasKudoed,
      this.workoutType,
      this.sufferScore,
      this.description,
      this.calories,
      this.segmentEfforts,
      this.splitsMetric,
      this.laps,
      this.gear,
      this.partnerBrandTag,
      this.photos,
      this.highlightedKudosers,
      this.deviceName,
      this.embedToken,
      this.segmentLeaderboardOptOut,
      this.leaderboardOptOut});

  factory DetailedActivity.fromJson(Map<String, dynamic> json) =>
      _$DetailedActivityFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedActivityToJson(this);
}

// Example value :
// destination_url : "strava://athletes/12345678987654321"
// display_name : "Marianne V."
// avatar_url : "https://dgalywyr863hv.cloudfront.net/pictures/athletes/12345678987654321/12345678987654321/3/medium.jpg"
// show_name : true
@JsonSerializable()
class HighlightedKudosers {
  @JsonKey(name: "destination_url")
  String? destinationUrl;

  @JsonKey(name: "display_name")
  String? displayName;

  @JsonKey(name: "avatar_url")
  String? avatarUrl;

  @JsonKey(name: "show_name")
  bool? showName;

  HighlightedKudosers(
      {this.destinationUrl, this.displayName, this.avatarUrl, this.showName});

  factory HighlightedKudosers.fromJson(Map<String, dynamic> json) =>
      _$HighlightedKudosersFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightedKudosersToJson(this);
}

// primary : {"id":null,"unique_id":"3FDGKL3-204E-4867-9E8D-89FC79EAAE17","urls":{"100":"https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-128x96.jpg","600":"https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-768x576.jpg"},"source":1}
// use_primary_photo : true
// count : 2
@JsonSerializable()
class PhotosSummary {
  @JsonKey(name: "primary", includeIfNull: false)
  PhotosSummaryPrimary? primary;

  @JsonKey(name: "use_primary_photo")
  bool? usePrimaryPhoto;

  @JsonKey(name: "count")
  int? count;

  PhotosSummary({this.primary, this.usePrimaryPhoto, this.count});

  factory PhotosSummary.fromJson(Map<String, dynamic> json) =>
      _$PhotosSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosSummaryToJson(this);
}

// id : null
// unique_id : "3FDGKL3-204E-4867-9E8D-89FC79EAAE17"
// urls : {"100":"https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-128x96.jpg","600":"https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-768x576.jpg"}
// source : 1
@JsonSerializable()
class PhotosSummaryPrimary {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "unique_id")
  String? uniqueId;

  @JsonKey(name: "urls", includeIfNull: false)
  ActivityUrls? urls;

  @JsonKey(name: "source")
  int? source;

  PhotosSummaryPrimary({this.id, this.uniqueId, this.urls, this.source});

  factory PhotosSummaryPrimary.fromJson(Map<String, dynamic> json) =>
      _$PhotosSummaryPrimaryFromJson(json);

  Map<String, dynamic> toJson() => _$PhotosSummaryPrimaryToJson(this);
}

// 100 : "https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-128x96.jpg"
// 600 : "https://dgtzuqphqg23d.cloudfront.net/Bv93zv5t_mr57v0wXFbY_JyvtucgmU5Ym6N9z_bKeUI-768x576.jpg"
class ActivityUrls {
  String? s100;
  String? s600;

  ActivityUrls({this.s100, this.s600});

  ActivityUrls.fromJson(dynamic json) {
    s100 = json['100'];
    s600 = json['600'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['s100'] = s100;
    map['s600'] = s600;
    return map;
  }
}

// id : 4479306946
// resource_state : 2
// name : "Lap 1"
// activity : {"id":1410355832,"resource_state":1}
// athlete : {"id":134815,"resource_state":1}
// elapsed_time : 1573
// moving_time : 1569
// start_date : "2018-02-16T14:52:54Z"
// start_date_local : "2018-02-16T06:52:54Z"
// distance : 8046.72
// start_index : 0
// end_index : 1570
// total_elevation_gain : 276
// average_speed : 5.12
// max_speed : 9.5
// average_cadence : 78.6
// device_watts : true
// average_watts : 233.1
// lap_index : 1
// split : 1

// distance : 1001.5
// elapsed_time : 141
// elevation_difference : 4.4
// moving_time : 141
// split : 1
// average_speed : 7.1
// pace_zone : 0
@JsonSerializable()
class SplitsMetric {
  /// The distance of this split, in meters.
  @JsonKey(name: "distance")
  double? distance;

  /// The elapsed time of this split, in seconds.
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;

  /// The elevation difference of this split, in meters.
  @JsonKey(name: "elevation_difference")
  double? elevationDifference;

  /// The moving time of this split, in seconds.
  @JsonKey(name: "moving_time")
  int? movingTime;

  @JsonKey(name: "split")
  int? split;

  /// The average speed of this split, in meters per second.
  @JsonKey(name: "average_speed")
  double? averageSpeed;

  @JsonKey(name: "pace_zone")
  int? paceZone;

  SplitsMetric(
      {this.distance,
      this.elapsedTime,
      this.elevationDifference,
      this.movingTime,
      this.split,
      this.averageSpeed,
      this.paceZone});

  factory SplitsMetric.fromJson(Map<String, dynamic> json) =>
      _$SplitsMetricFromJson(json);

  Map<String, dynamic> toJson() => _$SplitsMetricToJson(this);
}

// id : 12345678987654321
// resource_state : 2
// name : "Tunnel Rd."
// activity : {"id":12345678987654321,"resource_state":1}
// athlete : {"id":134815,"resource_state":1}
// elapsed_time : 2038
// moving_time : 2038
// start_date : "2018-02-16T14:56:25Z"
// start_date_local : "2018-02-16T06:56:25Z"
// distance : 9434.8
// start_index : 211
// end_index : 2246
// average_cadence : 78.6
// device_watts : true
// average_watts : 237.6
// segment : {"id":673683,"resource_state":2,"name":"Tunnel Rd.","activity_type":"Ride","distance":9220.7,"average_grade":4.2,"maximum_grade":25.8,"elevation_high":426.5,"elevation_low":43.4,"start_latlng":[37.8346153,-122.2520872],"end_latlng":[37.8476261,-122.2008944],"climb_category":3,"city":"Oakland","state":"CA","country":"United States","private":false,"hazardous":false,"starred":false}
// kom_rank : null
// pr_rank : null
// achievements : []
// hidden : false
@JsonSerializable()
class DetailedSegmentEffort {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "activity", includeIfNull: false)
  MetaActivity? activity;

  @JsonKey(name: "athlete", includeIfNull: false)
  MetaAthlete? athlete;

  @JsonKey(name: "elapsed_time")
  int? elapsedTime;

  @JsonKey(name: "moving_time")
  int? movingTime;

  @JsonKey(name: "start_date")
  String? startDate;

  @JsonKey(name: "start_date_local")
  String? startDateLocal;

  @JsonKey(name: "distance")
  double? distance;

  @JsonKey(name: "start_index")
  int? startIndex;

  @JsonKey(name: "end_index")
  int? endIndex;

  @JsonKey(name: "average_cadence")
  double? averageCadence;

  @JsonKey(name: "device_watts")
  bool? deviceWatts;

  @JsonKey(name: "average_watts")
  double? averageWatts;

  @JsonKey(name: "segment", includeIfNull: false)
  Segment? segment;

  @JsonKey(name: "kom_rank")
  int? komRank;

  @JsonKey(name: "pr_rank")
  int? prRank;

  @JsonKey(name: "achievements", includeIfNull: false)
  List<dynamic>? achievements;

  @JsonKey(name: "hidden")
  bool? hidden;

  DetailedSegmentEffort(
      {this.id,
      this.resourceState,
      this.name,
      this.activity,
      this.athlete,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.distance,
      this.startIndex,
      this.endIndex,
      this.averageCadence,
      this.deviceWatts,
      this.averageWatts,
      this.segment,
      this.komRank,
      this.prRank,
      this.achievements,
      this.hidden});

  factory DetailedSegmentEffort.fromJson(Map<String, dynamic> json) =>
      _$DetailedSegmentEffortFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedSegmentEffortToJson(this);
}

// id : 673683
// resource_state : 2
// name : "Tunnel Rd."
// activity_type : "Ride"
// distance : 9220.7
// average_grade : 4.2
// maximum_grade : 25.8
// elevation_high : 426.5
// elevation_low : 43.4
// start_latlng : [37.8346153,-122.2520872]
// end_latlng : [37.8476261,-122.2008944]
// climb_category : 3
// city : "Oakland"
// state : "CA"
// country : "United States"
// private : false
// hazardous : false
// starred : false
@JsonSerializable()
class Segment {
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

  /// The segment's average grade, in percents.
  @JsonKey(name: "average_grade")
  double? averageGrade;

  /// The segment's maximum grade, in percents.
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

  Segment(
      {this.id,
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
      this.starred});

  factory Segment.fromJson(Map<String, dynamic> json) =>
      _$SegmentFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentToJson(this);
}

// id : "a1410355832"
// polyline : "ki{eFvqfiVqAWQIGEEKAYJgBVqDJ{BHa@jAkNJw@Pw@V{APs@^aABQAOEQGKoJ_FuJkFqAo@{A}@sH{DiAs@Q]?WVy@`@oBt@_CB]KYMMkB{AQEI@WT{BlE{@zAQPI@ICsCqA_BcAeCmAaFmCqIoEcLeG}KcG}A}@cDaBiDsByAkAuBqBi@y@_@o@o@kB}BgIoA_EUkAMcACa@BeBBq@LaAJe@b@uA`@_AdBcD`@iAPq@RgALqAB{@EqAyAoOCy@AmCBmANqBLqAZkB\\iCPiBJwCCsASiCq@iD]eA]y@[i@w@mAa@i@k@g@kAw@i@Ya@Q]EWFMLa@~BYpAFNpA`Aj@n@X`@V`AHh@JfB@xAMvAGZGHIDIAWOEQNcC@sACYK[MSOMe@QKKKYOs@UYQISCQ?Q@WNo@r@OHGAGCKOQ_BU}@MQGG]Io@@c@FYNg@d@s@d@ODQAMOMaASs@_@a@SESAQDqBn@a@RO?KK?UBU\\kA@Y?WMo@Iy@GWQ_@WSSGg@AkABQB_Ap@_A^o@b@Q@o@IS@OHi@n@OFS?OI}@iAQMQGQC}@DOIIUK{@IUOMyBo@kASOKIQCa@L[|AgATWN[He@?QKw@FOPCh@Fx@l@TDLELKl@aAHIJEX@r@ZTDV@LENQVg@RkA@c@MeA?WFOPMf@Ej@Fj@@LGHKDM?_@_@iC?a@HKRIl@NT?FCHMFW?YEYGWQa@GYBiAIq@Gq@L_BHSHK|@WJETSLQZs@z@_A~@uA^U`@G\\CRB\\Tl@p@Th@JZ^bB`@lAHLXVLDP?LGFSKiDBo@d@wBVi@R]VYVE\\@`@Lh@Fh@CzAk@RSDQA]GYe@eAGWSiBAWBWBIJORK`@KPOPSTg@h@}Ad@o@F[E_@EGMKUGmAEYGMIMYKs@?a@J}@@_BD_@HQJMx@e@LKHKHWAo@UoAAWFmAH}@?w@C[YwAAc@HSNM|Ao@rA}@zAq@`@a@j@eAxAuBXQj@MXSR[b@gAFg@?YISOGaAHi@Xw@v@_@d@WRSFqARUHQJc@d@m@`A[VSFUBcAEU@WFULUPa@v@Y~@UrBc@dBI~@?l@P~ABt@N`HEjA]zAEp@@p@TrBCl@CTQb@k@dAg@jAU^KJYLK@k@A[Js@d@a@b@]RgBl@[FMAw@[]G]?m@D_@F]P[Vu@t@[TMF_@Do@E_@@q@P]PWZUZw@vAkAlAGJOj@IlAMd@OR{@p@a@d@sBpD]v@a@`Aa@n@]TODgBVk@Pe@^cBfBc@Rs@La@RSPm@|@wCpDS^Wp@QZML{@l@qBbCYd@k@lAIVCZBZNTr@`@RRHZANIZQPKDW@e@CaASU?I@YTKRQx@@\\VmALYRQLCL?v@P|@D\\GJEFKDM@OCa@COOYIGm@YMUCM@]JYr@uAx@kAt@}@jAeAPWbAkBj@s@bAiAz@oAj@m@VQlAc@VQ~@aA`Au@p@Q`AIv@MZORUV_@p@iB|AoCh@q@dAaANUNWH[N{AJ[^m@t@_Av@wA\\a@`@W`@In@Al@B^E`@Wl@u@\\[VQ\\K`@Eb@?R@dAZP@d@CRExAs@\\Yt@{@LG\\MjAATINOXo@d@kAl@_AHYBOCe@QiBCm@Fq@\\wADo@AyGEeBWuB@YHu@Tu@Lk@VcCTo@d@aA\\WJE`@G~@FP?VI\\U~@sANO`@SfAMj@U\\WjAsAXS`@UNENALBHFFL?^Ml@Uj@]b@q@RUJSPkChEc@XcAb@sA|@]PaA\\OJKNER?TDTNj@Jn@?p@OfC@ZR`B@VCV_@n@{@l@WbACv@OlABnAPl@LNNHbBBNBLFFJ@^GLg@x@i@|AMP[X}@XOJKPET?l@LhAFXp@fBDRCd@S\\_@Ps@PQ@}A]S?QDe@V]b@MR[fAKt@ErAF~CANILYDKGIKe@{@Yy@e@sB[gA[c@e@YUCU?WBUHUNQPq@`AiArAMV[^e@Zc@JQJKNMz@?r@Bb@PfAAfA@VVbADn@E`@KHSEe@SMAKDKFM\\^dDCh@m@LoAQ_@@MFOZLfBEl@QbASd@KLQBOAaAc@QAQ@QHc@v@ONMJOBOCg@c@]O[EMBKFGL?RHv@ARERGNe@h@{@h@WVGNDt@JLNFPFz@LdBf@f@PJNHPF`ADPJJJDl@I`@B^Tp@bALJNDNALIf@i@PGPCt@DNE`@Uv@[dAw@RITGRCtAARBPJLPJRZxB?VEX_@vAAR?RDNHJJBh@UnBm@h@IRDRJNNJPNbBFRJLLBLCzAmAd@Uf@Gf@?P@PFJNHPFTH`BDTHNJJJ@LG`@m@^YPER@RDPHNNJRLn@HRLN^VNPHTFX@\\UlDFb@FHh@NP@HKPsB?}ASkCQ{@[y@q@}@cA{@KOCQDa@t@{CFGJCf@Nl@ZtA~@r@p@`@h@rAxBd@rA\\fARdAPjANrB?f@AtBCd@QfBkAjJOlBChA?rBFrBNlBdAfKFzAC~@Iz@Mz@Sv@s@jBmAxBi@hAWt@Sv@Qx@O`BA`@?dAPfBVpAd@`BfBlFf@fBdA~Cr@pAz@fApBhBjAt@H?IL?FBFJLx@^lHvDvh@~XnElCbAd@pGhDbAb@nAr@`Ad@`GhDnBbAxCbBrWhNJJDPARGP_@t@Qh@]pAUtAoA`Ny@jJApBBNFLJFJBv@Hb@HBF?\\"
// resource_state : 3
// summary_polyline : "ki{eFvqfiVsBmA`Feh@qg@iX`B}JeCcCqGjIq~@kf@cM{KeHeX`@_GdGkSeBiXtB}YuEkPwFyDeAzAe@pC~DfGc@bIOsGmCcEiD~@oBuEkFhBcBmDiEfAVuDiAuD}NnDaNiIlCyDD_CtJKv@wGhD]YyEzBo@g@uKxGmHpCGtEtI~AuLrHkAcAaIvEgH_EaDR_FpBuBg@sNxHqEtHgLoTpIiCzKNr[sB|Es\\`JyObYeMbGsMnPsAfDxAnD}DBu@bCx@{BbEEyAoD`AmChNoQzMoGhOwX|[yIzBeFKg[zAkIdU_LiHxK}HzEh@vM_BtBg@xGzDbCcF~GhArHaIfByAhLsDiJuC?_HbHd@nL_Cz@ZnEkDDy@hHwJLiCbIrNrIvN_EfAjDWlEnEiAfBxDlFkBfBtEfDaAzBvDKdFx@|@XgJmDsHhAgD`GfElEzOwBnYdBxXgGlSc@bGdHpW|HdJztBnhAgFxc@HnCvBdA"
@JsonSerializable()
class PolyLineMap {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "polyline")
  String? polyline;

  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "summary_polyline")
  String? summaryPolyline;

  PolyLineMap(
      {this.id, this.polyline, this.resourceState, this.summaryPolyline});

  factory PolyLineMap.fromJson(Map<String, dynamic> json) =>
      _$PolyLineMapFromJson(json);

  Map<String, dynamic> toJson() => _$PolyLineMapToJson(this);
}
