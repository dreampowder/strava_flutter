import 'package:json_annotation/json_annotation.dart';

part 'model_stream_set.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the data field is absent from the JSON payload.
List<double>? _doubleListFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

/// A single data stream for an activity, route, segment or segment effort.
///
/// Each stream describes one channel (e.g. `distance`, `heartrate`, `watts`)
/// over the course of the entity. Use [StreamCollection] to retrieve several
/// channels keyed by type in a single call.
// type : "distance"
// data : [2.9,5.8,8.5,11.7,15,19,23.2,28,32.8,38.1,43.8,49.5]
// series_type : "distance"
// original_size : 12
// resolution : "high"
@JsonSerializable()
class StravaStream {
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "data", fromJson: _doubleListFromJson)
  List<double>? data;
  @JsonKey(name: "series_type")
  String? seriesType;
  @JsonKey(name: "original_size")
  int? originalSize;
  @JsonKey(name: "resolution")
  String? resolution;

  StravaStream({
    this.type,
    this.data,
    this.seriesType,
    this.originalSize,
    this.resolution,
  });

  factory StravaStream.fromJson(Map<String, dynamic> json) =>
      _$StravaStreamFromJson(json);

  Map<String, dynamic> toJson() => _$StravaStreamToJson(this);
}

/// Deprecated alias for [StravaStream].
///
/// The old name was misleading: this type models a *single* stream, not a set
/// of streams. The keyed object that Strava calls a "StreamSet" is now modeled
/// by [StreamCollection]. This alias is kept for source compatibility and will
/// be removed in the next major version.
@Deprecated(
  'Renamed to StravaStream. A single stream is not a "set". '
  'For the keyed object use StreamCollection. Removed in the next major.',
)
typedef StreamSet = StravaStream;
