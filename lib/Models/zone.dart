// zones
import 'fault.dart';

class Zone {
  Fault fault;
  List<DistributionBuckets> distributionBuckets;
  // ErrorCode error;
  String type;
  int resourceState;
  bool sensorBased;

  Zone(
      {this.fault,
      this.distributionBuckets,
      this.type,
      this.resourceState,
      this.sensorBased});

  Zone.fromJson(Map<String, dynamic> json) {
    if (json['distribution_buckets'] != null) {
      distributionBuckets = new List<DistributionBuckets>();
      json['distribution_buckets'].forEach((v) {
        distributionBuckets.add(new DistributionBuckets.fromJson(v));
      });
    }
    type = json['type'];
    resourceState = json['resource_state'];
    sensorBased = json['sensor_based'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributionBuckets != null) {
      data['distribution_buckets'] =
          this.distributionBuckets.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['resource_state'] = this.resourceState;
    data['sensor_based'] = this.sensorBased;
    return data;
  }
}

class DistributionBuckets {
  int max;
  int min;
  int time;

  DistributionBuckets({this.max, this.min, this.time});

  DistributionBuckets.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    min = json['min'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['min'] = this.min;
    data['time'] = this.time;
    return data;
  }
}
