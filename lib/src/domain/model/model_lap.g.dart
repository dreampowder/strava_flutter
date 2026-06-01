// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_lap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lap _$LapFromJson(Map<String, dynamic> json) => Lap(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
  name: json['name'] as String?,
  activity: json['activity'] == null
      ? null
      : MetaActivity.fromJson(json['activity'] as Map<String, dynamic>),
  athlete: json['athlete'] == null
      ? null
      : MetaAthlete.fromJson(json['athlete'] as Map<String, dynamic>),
  elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
  movingTime: (json['moving_time'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
  startDateLocal: json['start_date_local'] as String?,
  distance: (json['distance'] as num?)?.toDouble(),
  startIndex: (json['start_index'] as num?)?.toInt(),
  endIndex: (json['end_index'] as num?)?.toInt(),
  totalElevationGain: (json['total_elevation_gain'] as num?)?.toDouble(),
  averageSpeed: (json['average_speed'] as num?)?.toDouble(),
  maxSpeed: (json['max_speed'] as num?)?.toDouble(),
  averageCadence: (json['average_cadence'] as num?)?.toDouble(),
  deviceWatts: json['device_watts'] as bool?,
  averageWatts: (json['average_watts'] as num?)?.toDouble(),
  lapIndex: (json['lap_index'] as num?)?.toInt(),
  split: (json['split'] as num?)?.toInt(),
);

Map<String, dynamic> _$LapToJson(Lap instance) => <String, dynamic>{
  'id': instance.id,
  'resource_state': instance.resourceState,
  'name': instance.name,
  'activity': ?instance.activity?.toJson(),
  'athlete': ?instance.athlete?.toJson(),
  'elapsed_time': instance.elapsedTime,
  'moving_time': instance.movingTime,
  'start_date': instance.startDate,
  'start_date_local': instance.startDateLocal,
  'distance': instance.distance,
  'start_index': instance.startIndex,
  'end_index': instance.endIndex,
  'total_elevation_gain': instance.totalElevationGain,
  'average_speed': instance.averageSpeed,
  'max_speed': instance.maxSpeed,
  'average_cadence': instance.averageCadence,
  'device_watts': instance.deviceWatts,
  'average_watts': instance.averageWatts,
  'lap_index': instance.lapIndex,
  'split': instance.split,
};

MetaAthlete _$MetaAthleteFromJson(Map<String, dynamic> json) => MetaAthlete(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetaAthleteToJson(MetaAthlete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_state': instance.resourceState,
    };

MetaActivity _$MetaActivityFromJson(Map<String, dynamic> json) => MetaActivity(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetaActivityToJson(MetaActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_state': instance.resourceState,
    };
