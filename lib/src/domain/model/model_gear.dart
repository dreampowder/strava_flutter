// id : "b1231"
// primary : false
// resource_state : 3
// distance : 388206
// brand_name : "BMC"
// model_name : "Teammachine"
// frame_type : 3
// description : "My Bike."
import 'package:json_annotation/json_annotation.dart';

part 'model_gear.g.dart';

@JsonSerializable()
class Gear {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "primary")
  bool? primary;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "distance")
  int? distance;

  @JsonKey(name: "brand_name")
  String? brandName;

  @JsonKey(name: "model_name")
  String? modelName;

  @JsonKey(name: "frame_type")
  int? frameType;

  @JsonKey(name: "description")
  String? description;

  Gear(
      {this.id,
      this.primary,
      this.resourceState,
      this.distance,
      this.brandName,
      this.modelName,
      this.frameType,
      this.description});

  factory Gear.fromJson(Map<String, dynamic> json) => _$GearFromJson(json);

  Map<String, dynamic> toJson() => _$GearToJson(this);
}
