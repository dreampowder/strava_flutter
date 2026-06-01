// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_running_race.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunningRace _$RunningRaceFromJson(Map<String, dynamic> json) => RunningRace(
  country: json['country'] as String?,
  routeIds: _routeIdsFromJson(json['route_ids']),
  runningRaceType: (json['running_race_type'] as num?)?.toInt(),
  distance: (json['distance'] as num?)?.toDouble(),
  websiteUrl: json['website_url'] as String?,
  city: json['city'] as String?,
  startDateLocal: json['start_date_local'] as String?,
  name: json['name'] as String?,
  measurementPreference: json['measurement_preference'] as String?,
  id: (json['id'] as num?)?.toInt(),
  state: json['state'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$RunningRaceToJson(RunningRace instance) =>
    <String, dynamic>{
      'country': instance.country,
      'route_ids': instance.routeIds,
      'running_race_type': instance.runningRaceType,
      'distance': instance.distance,
      'website_url': instance.websiteUrl,
      'city': instance.city,
      'start_date_local': instance.startDateLocal,
      'name': instance.name,
      'measurement_preference': instance.measurementPreference,
      'id': instance.id,
      'state': instance.state,
      'url': instance.url,
    };
