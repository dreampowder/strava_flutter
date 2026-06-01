import 'package:json_annotation/json_annotation.dart';

part 'model_activity_zone.g.dart';

// Example of value :
// ```dart
// ActivityZone(
//   score: 0,
//   sensorBased: true,
//   customZones: true,
//   max: 1,
//   distributionBuckets: '',
//   type: 'heartrate',
//   points: 6,
// );
// ```
@JsonSerializable()
class ActivityZone {
  @JsonKey(name: "score")
  int? score;

  @JsonKey(name: "sensor_based")
  bool? sensorBased;

  @JsonKey(name: "custom_zones")
  bool? customZones;

  @JsonKey(name: "max")
  int? max;

  @JsonKey(name: "distribution_buckets")
  String? distributionBuckets;

  /// May take one of the following values: `heartrate`, `power`.
  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "points")
  int? points;

  ActivityZone({
    this.score,
    this.sensorBased,
    this.customZones,
    this.max,
    this.distributionBuckets,
    this.type,
    this.points,
  });

  factory ActivityZone.fromJson(Map<String, dynamic> json) =>
      _$ActivityZoneFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityZoneToJson(this);
}
