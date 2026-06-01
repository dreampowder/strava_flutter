import 'package:json_annotation/json_annotation.dart';

part 'model_athlete_zones.g.dart';

/// The authenticated athlete's heart-rate and power zones, as returned by
/// `GET /athlete/zones`.
///
/// This is the correct model for that endpoint (a single object keyed by
/// `heart_rate` / `power`). The older `Zones` type / `getZones()` mismodeled
/// this endpoint and is deprecated.
@JsonSerializable()
class AthleteZones {
  @JsonKey(name: "heart_rate", includeIfNull: false)
  HeartRateZoneRanges? heartRate;

  @JsonKey(name: "power", includeIfNull: false)
  PowerZoneRanges? power;

  AthleteZones({this.heartRate, this.power});

  factory AthleteZones.fromJson(Map<String, dynamic> json) =>
      _$AthleteZonesFromJson(json);

  Map<String, dynamic> toJson() => _$AthleteZonesToJson(this);
}

@JsonSerializable()
class HeartRateZoneRanges {
  /// Whether the athlete has set their own custom heart-rate zones.
  @JsonKey(name: "custom_zones")
  bool? customZones;

  @JsonKey(name: "zones")
  List<ZoneRange>? zones;

  HeartRateZoneRanges({this.customZones, this.zones});

  factory HeartRateZoneRanges.fromJson(Map<String, dynamic> json) =>
      _$HeartRateZoneRangesFromJson(json);

  Map<String, dynamic> toJson() => _$HeartRateZoneRangesToJson(this);
}

@JsonSerializable()
class PowerZoneRanges {
  @JsonKey(name: "zones")
  List<ZoneRange>? zones;

  PowerZoneRanges({this.zones});

  factory PowerZoneRanges.fromJson(Map<String, dynamic> json) =>
      _$PowerZoneRangesFromJson(json);

  Map<String, dynamic> toJson() => _$PowerZoneRangesToJson(this);
}

/// A single zone range. A `min` of 0 marks the lowest zone; a `max` of -1
/// marks the highest.
@JsonSerializable()
class ZoneRange {
  @JsonKey(name: "min")
  int? min;

  @JsonKey(name: "max")
  int? max;

  ZoneRange({this.min, this.max});

  factory ZoneRange.fromJson(Map<String, dynamic> json) =>
      _$ZoneRangeFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneRangeToJson(this);
}
