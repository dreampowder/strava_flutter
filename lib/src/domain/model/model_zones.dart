// To parse this JSON data, do
//
//     final zones = zonesFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_zones.g.dart';

@JsonSerializable()
class Zones {
  Zones({
    required this.distributionBuckets,
    required this.type,
    required this.resourceState,
    required this.sensorBased,
  });

  @JsonKey(name: "distribution_buckets")
  List<DistributionBucket> distributionBuckets;

  @JsonKey(name: "type")
  String type;

  @JsonKey(name: "resource_state")
  int resourceState;

  @JsonKey(name: "sensor_based")
  bool sensorBased;

  factory Zones.fromRawJson(String str) => Zones.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Zones.fromJson(Map<String, dynamic> json) => _$ZonesFromJson(json);

  Map<String, dynamic> toJson() => _$ZonesToJson(this);
}

@JsonSerializable()
class DistributionBucket {
  DistributionBucket({
    required this.max,
    required this.min,
    required this.time,
  });

  @JsonKey(name: "max")
  int max;

  @JsonKey(name: "min")
  int min;

  @JsonKey(name: "time")
  int time;

  factory DistributionBucket.fromRawJson(String str) =>
      DistributionBucket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistributionBucket.fromJson(Map<String, dynamic> json) =>
      _$DistributionBucketFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionBucketToJson(this);
}
