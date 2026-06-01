// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_stream_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamCollection _$StreamCollectionFromJson(Map<String, dynamic> json) =>
    StreamCollection(
      time: json['time'] == null
          ? null
          : StravaStream.fromJson(json['time'] as Map<String, dynamic>),
      distance: json['distance'] == null
          ? null
          : StravaStream.fromJson(json['distance'] as Map<String, dynamic>),
      latlng: json['latlng'] == null
          ? null
          : StravaStream.fromJson(json['latlng'] as Map<String, dynamic>),
      altitude: json['altitude'] == null
          ? null
          : StravaStream.fromJson(json['altitude'] as Map<String, dynamic>),
      velocitySmooth: json['velocity_smooth'] == null
          ? null
          : StravaStream.fromJson(
              json['velocity_smooth'] as Map<String, dynamic>,
            ),
      heartrate: json['heartrate'] == null
          ? null
          : StravaStream.fromJson(json['heartrate'] as Map<String, dynamic>),
      cadence: json['cadence'] == null
          ? null
          : StravaStream.fromJson(json['cadence'] as Map<String, dynamic>),
      watts: json['watts'] == null
          ? null
          : StravaStream.fromJson(json['watts'] as Map<String, dynamic>),
      temp: json['temp'] == null
          ? null
          : StravaStream.fromJson(json['temp'] as Map<String, dynamic>),
      moving: json['moving'] == null
          ? null
          : StravaStream.fromJson(json['moving'] as Map<String, dynamic>),
      gradeSmooth: json['grade_smooth'] == null
          ? null
          : StravaStream.fromJson(json['grade_smooth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreamCollectionToJson(StreamCollection instance) =>
    <String, dynamic>{
      'time': ?instance.time?.toJson(),
      'distance': ?instance.distance?.toJson(),
      'latlng': ?instance.latlng?.toJson(),
      'altitude': ?instance.altitude?.toJson(),
      'velocity_smooth': ?instance.velocitySmooth?.toJson(),
      'heartrate': ?instance.heartrate?.toJson(),
      'cadence': ?instance.cadence?.toJson(),
      'watts': ?instance.watts?.toJson(),
      'temp': ?instance.temp?.toJson(),
      'moving': ?instance.moving?.toJson(),
      'grade_smooth': ?instance.gradeSmooth?.toJson(),
    };
