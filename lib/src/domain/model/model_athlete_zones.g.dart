// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_athlete_zones.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AthleteZones _$AthleteZonesFromJson(Map<String, dynamic> json) => AthleteZones(
  heartRate: json['heart_rate'] == null
      ? null
      : HeartRateZoneRanges.fromJson(
          json['heart_rate'] as Map<String, dynamic>,
        ),
  power: json['power'] == null
      ? null
      : PowerZoneRanges.fromJson(json['power'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AthleteZonesToJson(AthleteZones instance) =>
    <String, dynamic>{
      'heart_rate': ?instance.heartRate?.toJson(),
      'power': ?instance.power?.toJson(),
    };

HeartRateZoneRanges _$HeartRateZoneRangesFromJson(Map<String, dynamic> json) =>
    HeartRateZoneRanges(
      customZones: json['custom_zones'] as bool?,
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => ZoneRange.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HeartRateZoneRangesToJson(
  HeartRateZoneRanges instance,
) => <String, dynamic>{
  'custom_zones': instance.customZones,
  'zones': instance.zones?.map((e) => e.toJson()).toList(),
};

PowerZoneRanges _$PowerZoneRangesFromJson(Map<String, dynamic> json) =>
    PowerZoneRanges(
      zones: (json['zones'] as List<dynamic>?)
          ?.map((e) => ZoneRange.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PowerZoneRangesToJson(PowerZoneRanges instance) =>
    <String, dynamic>{'zones': instance.zones?.map((e) => e.toJson()).toList()};

ZoneRange _$ZoneRangeFromJson(Map<String, dynamic> json) => ZoneRange(
  min: (json['min'] as num?)?.toInt(),
  max: (json['max'] as num?)?.toInt(),
);

Map<String, dynamic> _$ZoneRangeToJson(ZoneRange instance) => <String, dynamic>{
  'min': instance.min,
  'max': instance.max,
};
