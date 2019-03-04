// gear.dart

import 'fault.dart';


class Gear {
  Fault fault;
  String id;
  bool primary;
  int resourceState;
  double distance;
  String brandName;
  String modelName;
  int frameType;
  String description;

  Gear(
      {Fault fault,
      this.id,
      this.primary,
      this.resourceState,
      this.distance,
      this.brandName,
      this.modelName,
      this.frameType,
      this.description}): fault = Fault(88, '');

  Gear.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['primary'] = this.primary;
    data['resource_state'] = this.resourceState;
    data['distance'] = this.distance;
    data['brand_name'] = this.brandName;
    data['model_name'] = this.modelName;
    data['frame_type'] = this.frameType;
    data['description'] = this.description;
    return data;
  }
}
