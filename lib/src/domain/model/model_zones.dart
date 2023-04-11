// To parse this JSON data, do
//
//     final zones = zonesFromJson(jsonString);

import 'dart:convert';

class Zones {
  Zones({
    required this.distributionBuckets,
    required this.type,
    required this.resourceState,
    required this.sensorBased,
  });

  List<DistributionBucket> distributionBuckets;
  String type;
  int resourceState;
  bool sensorBased;

  factory Zones.fromRawJson(String str) => Zones.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zones.fromJson(Map<String, dynamic> json) => Zones(
        distributionBuckets: List<DistributionBucket>.from(
            json["distribution_buckets"]
                .map((x) => DistributionBucket.fromJson(x))),
        type: json["type"],
        resourceState: json["resource_state"],
        sensorBased: json["sensor_based"],
      );

  Map<String, dynamic> toJson() => {
        "distribution_buckets":
            List<dynamic>.from(distributionBuckets.map((x) => x.toJson())),
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

  int max;
  int min;
  int time;

  factory DistributionBucket.fromRawJson(String str) =>
      DistributionBucket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistributionBucket.fromJson(Map<String, dynamic> json) =>
      DistributionBucket(
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
