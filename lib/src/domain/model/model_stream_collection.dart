import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_stream_set.dart';

part 'model_stream_collection.g.dart';

/// A set of [StravaStream]s keyed by stream type.
///
/// Returned by the `*ByType` stream endpoints (Strava's `key_by_type=true`
/// form). Only the requested / available channels are populated; the rest are
/// `null`. This is the object Strava's API reference calls a `StreamSet`.
@JsonSerializable()
class StreamCollection {
  @JsonKey(name: "time", includeIfNull: false)
  StravaStream? time;

  @JsonKey(name: "distance", includeIfNull: false)
  StravaStream? distance;

  @JsonKey(name: "latlng", includeIfNull: false)
  StravaStream? latlng;

  @JsonKey(name: "altitude", includeIfNull: false)
  StravaStream? altitude;

  @JsonKey(name: "velocity_smooth", includeIfNull: false)
  StravaStream? velocitySmooth;

  @JsonKey(name: "heartrate", includeIfNull: false)
  StravaStream? heartrate;

  @JsonKey(name: "cadence", includeIfNull: false)
  StravaStream? cadence;

  @JsonKey(name: "watts", includeIfNull: false)
  StravaStream? watts;

  @JsonKey(name: "temp", includeIfNull: false)
  StravaStream? temp;

  @JsonKey(name: "moving", includeIfNull: false)
  StravaStream? moving;

  @JsonKey(name: "grade_smooth", includeIfNull: false)
  StravaStream? gradeSmooth;

  StreamCollection({
    this.time,
    this.distance,
    this.latlng,
    this.altitude,
    this.velocitySmooth,
    this.heartrate,
    this.cadence,
    this.watts,
    this.temp,
    this.moving,
    this.gradeSmooth,
  });

  factory StreamCollection.fromJson(Map<String, dynamic> json) =>
      _$StreamCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$StreamCollectionToJson(this);
}
