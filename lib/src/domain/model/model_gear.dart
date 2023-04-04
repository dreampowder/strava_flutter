// id : "b1231"
// primary : false
// resource_state : 3
// distance : 388206
// brand_name : "BMC"
// model_name : "Teammachine"
// frame_type : 3
// description : "My Bike."
class Gear {
  String? id;
  bool? primary;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 2 -> `summary`, 3 -> `detail`.
  int? resourceState;
  int? distance;
  String? brandName;
  String? modelName;
  int? frameType;
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

  Gear.fromJson(dynamic json) {
    id = json['id'];
    primary = json['primary'];
    resourceState = json['resource_state'];
    distance = json['distance'];
    brandName = json['brand_name'];
    modelName = json['model_name'];
    frameType = json['frame_type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['primary'] = primary;
    map['resource_state'] = resourceState;
    map['distance'] = distance;
    map['brand_name'] = brandName;
    map['model_name'] = modelName;
    map['frame_type'] = frameType;
    map['description'] = description;
    return map;
  }
}
