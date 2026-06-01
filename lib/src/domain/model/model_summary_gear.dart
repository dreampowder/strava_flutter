import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_summary_gear.g.dart';

// id : "b12345678987654321"
// primary : true
// name : "Tarmac"
// resource_state : 2
// distance : 32547610
@JsonSerializable()
class SummaryGear {
  SummaryGear({
    required this.id,
    required this.primary,
    required this.name,
    required this.resourceState,
    required this.distance,
  });

  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "primary")
  bool primary;

  @JsonKey(name: "name")
  String name;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state")
  int resourceState;

  @JsonKey(name: "distance")
  int distance;

  factory SummaryGear.fromRawJson(String str) =>
      SummaryGear.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryGear.fromJson(Map<String, dynamic> json) =>
      _$SummaryGearFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryGearToJson(this);
}
