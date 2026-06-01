import 'package:json_annotation/json_annotation.dart';

part 'model_lap.g.dart';

@JsonSerializable()
class Lap {
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

  /// The lap's elapsed time, in seconds.
  @JsonKey(name: "elapsed_time")
  int? elapsedTime;

  /// The lap's moving time, in seconds.
  @JsonKey(name: "moving_time")
  int? movingTime;

  @JsonKey(name: "start_date")
  String? startDate;

  @JsonKey(name: "start_date_local")
  String? startDateLocal;

  /// The lap's distance, in meters.
  @JsonKey(name: "distance")
  double? distance;

  @JsonKey(name: "start_index")
  int? startIndex;

  @JsonKey(name: "end_index")
  int? endIndex;

  /// The elevation gain of this lap, in meters.
  @JsonKey(name: "total_elevation_gain")
  double? totalElevationGain;

  @JsonKey(name: "average_speed")
  double? averageSpeed;

  /// The maximum speed of this lat, in meters per second.
  @JsonKey(name: "max_speed")
  double? maxSpeed;

  @JsonKey(name: "average_cadence")
  double? averageCadence;

  @JsonKey(name: "device_watts")
  bool? deviceWatts;

  @JsonKey(name: "average_watts")
  double? averageWatts;

  @JsonKey(name: "lap_index")
  int? lapIndex;

  @JsonKey(name: "split")
  int? split;

  @JsonKey(name: "pace_zone")
  int? paceZone;

  Lap({
    this.id,
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
    this.totalElevationGain,
    this.averageSpeed,
    this.maxSpeed,
    this.averageCadence,
    this.deviceWatts,
    this.averageWatts,
    this.lapIndex,
    this.split,
    this.paceZone,
  });

  factory Lap.fromJson(Map<String, dynamic> json) => _$LapFromJson(json);

  Map<String, dynamic> toJson() => _$LapToJson(this);
}

// id : 134815
// resource_state : 1
@JsonSerializable()
class MetaAthlete {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "resource_state")
  int? resourceState;

  MetaAthlete({this.id, this.resourceState});

  factory MetaAthlete.fromJson(Map<String, dynamic> json) =>
      _$MetaAthleteFromJson(json);

  Map<String, dynamic> toJson() => _$MetaAthleteToJson(this);
}

// id : 1410355832
// resource_state : 1
@JsonSerializable()
class MetaActivity {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "resource_state")
  int? resourceState;

  MetaActivity({this.id, this.resourceState});

  factory MetaActivity.fromJson(Map<String, dynamic> json) =>
      _$MetaActivityFromJson(json);

  Map<String, dynamic> toJson() => _$MetaActivityToJson(this);
}
