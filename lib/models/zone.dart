// zones
import 'dart:convert';

class Zone {
  Zone({
    required this.distributionBuckets,
    required this.type,
    required this.resourceState,
    required this.sensorBased,
  });

  final List<DistributionBucket> distributionBuckets;
  final String type;
  final int resourceState;
  final bool sensorBased;

  factory Zone.fromRawJson(String str) => Zone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    distributionBuckets: List<DistributionBucket>.from(json["distribution_buckets"].map((x) => DistributionBucket.fromJson(x))),
    type: json["type"],
    resourceState: json["resource_state"],
    sensorBased: json["sensor_based"],
  );

  Map<String, dynamic> toJson() => {
    "distribution_buckets": List<dynamic>.from(distributionBuckets.map((x) => x.toJson())),
    "type": type,
    "resource_state": resourceState,
    "sensor_based": sensorBased,
  };
}

class DistributionBucket {
  DistributionBucket({
    required this.max,
    required this.min,
    required this.time,
  });

  final int max;
  final int min;
  final int time;

  factory DistributionBucket.fromRawJson(String str) => DistributionBucket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistributionBucket.fromJson(Map<String, dynamic> json) => DistributionBucket(
    max: json["max"],
    min: json["min"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "max": max,
    "min": min,
    "time": time,
  };
}
