import 'package:json_annotation/json_annotation.dart';

part 'model_stream_set.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the data field is absent from the JSON payload.
List<double>? _doubleListFromJson(dynamic value) =>
    value != null ? (value as List).cast<double>() : <double>[];

// type : "distance"
// data : [2.9,5.8,8.5,11.7,15,19,23.2,28,32.8,38.1,43.8,49.5]
// series_type : "distance"
// original_size : 12
// resolution : "high"
@JsonSerializable()
class StreamSet {
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

  StreamSet(
      {this.type,
      this.data,
      this.seriesType,
      this.originalSize,
      this.resolution});

  factory StreamSet.fromJson(Map<String, dynamic> json) =>
      _$StreamSetFromJson(json);

  Map<String, dynamic> toJson() => _$StreamSetToJson(this);
}
