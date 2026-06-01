import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_detailed_activity.dart';
import 'package:strava_client/src/domain/model/model_lap.dart';

part 'model_summary_activity.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the latlng field is absent from the JSON payload.
List<double>? _latLngFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

@JsonSerializable()
class SummaryActivity {
  @JsonKey(name: "resource_state")
  int? resourceState;

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

  @JsonKey(name: "workout_type")
  int? workoutType;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "external_id")
  String? externalId;

  @JsonKey(name: "upload_id")
  int? uploadId;

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

  @JsonKey(name: "location_city")
  String? locationCity;

  @JsonKey(name: "location_state")
  String? locationState;

  @JsonKey(name: "location_country")
  String? locationCountry;

  @JsonKey(name: "achievement_count")
  int? achievementCount;

  @JsonKey(name: "kudos_count")
  int? kudosCount;

  @JsonKey(name: "comment_count")
  int? commentCount;

  @JsonKey(name: "athlete_count")
  int? athleteCount;

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

  @JsonKey(name: "average_watts")
  double? averageWatts;

  @JsonKey(name: "weighted_average_watts")
  int? weightedAverageWatts;

  @JsonKey(name: "kilojoules")
  double? kilojoules;

  /// Whether the watts are from a power meter, `false` if estimated.
  @JsonKey(name: "device_watts")
  bool? deviceWatts;

  @JsonKey(name: "has_heartrate")
  bool? hasHeartrate;

  @JsonKey(name: "average_heartrate")
  double? averageHeartrate;

  @JsonKey(name: "max_heartrate")
  double? maxHeartrate;

  @JsonKey(name: "max_watts")
  int? maxWatts;

  @JsonKey(name: "pr_count")
  int? prCount;

  @JsonKey(name: "total_photo_count")
  int? totalPhotoCount;

  @JsonKey(name: "has_kudoed")
  bool? hasKudoed;

  @JsonKey(name: "suffer_score")
  double? sufferScore;

  SummaryActivity(
      {this.resourceState,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.workoutType,
      this.id,
      this.externalId,
      this.uploadId,
      this.startDate,
      this.startDateLocal,
      this.timezone,
      this.utcOffset,
      this.startLatlng,
      this.endLatlng,
      this.locationCity,
      this.locationState,
      this.locationCountry,
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
      this.averageWatts,
      this.weightedAverageWatts,
      this.kilojoules,
      this.deviceWatts,
      this.hasHeartrate,
      this.averageHeartrate,
      this.maxHeartrate,
      this.maxWatts,
      this.prCount,
      this.totalPhotoCount,
      this.hasKudoed,
      this.sufferScore});

  factory SummaryActivity.fromJson(Map<String, dynamic> json) =>
      _$SummaryActivityFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryActivityToJson(this);
}
