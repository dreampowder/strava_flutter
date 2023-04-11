// Example of value :
// ```dart
// ActivityZone(
//   score: 0,
//   sensorBased: true,
//   customZones: true,
//   max: 1,
//   distributionBuckets: '',
//   type: 'heartrate',
//   points: 6,
// );
// ```
class ActivityZone {
  int? score;
  bool? sensorBased;
  bool? customZones;
  int? max;
  String? distributionBuckets;

  /// May take one of the following values: `heartrate`, `power`.
  String? type;
  int? points;

  ActivityZone(
      {this.score,
      this.sensorBased,
      this.customZones,
      this.max,
      this.distributionBuckets,
      this.type,
      this.points});

  ActivityZone.fromJson(dynamic json) {
    score = json['score'];
    sensorBased = json['sensor_based'];
    customZones = json['custom_zones'];
    max = json['max'];
    distributionBuckets = json['distribution_buckets'];
    type = json['type'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['score'] = score;
    map['sensor_based'] = sensorBased;
    map['custom_zones'] = customZones;
    map['max'] = max;
    map['distribution_buckets'] = distributionBuckets;
    map['type'] = type;
    map['points'] = points;
    return map;
  }
}
