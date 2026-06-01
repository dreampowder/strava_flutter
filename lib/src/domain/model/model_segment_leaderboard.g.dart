// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_segment_leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SegmentLeaderboard _$SegmentLeaderboardFromJson(Map<String, dynamic> json) =>
    SegmentLeaderboard(
      effortCount: (json['effort_count'] as num?)?.toInt(),
      entryCount: (json['entry_count'] as num?)?.toInt(),
      komType: json['kom_type'] as String?,
      entries: (json['entries'] as List<dynamic>?)
          ?.map(
            (e) => SegmentLeaderboardEntry.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SegmentLeaderboardToJson(SegmentLeaderboard instance) =>
    <String, dynamic>{
      'effort_count': instance.effortCount,
      'entry_count': instance.entryCount,
      'kom_type': instance.komType,
      'entries': instance.entries?.map((e) => e.toJson()).toList(),
    };

SegmentLeaderboardEntry _$SegmentLeaderboardEntryFromJson(
  Map<String, dynamic> json,
) => SegmentLeaderboardEntry(
  athleteName: json['athlete_name'] as String?,
  elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
  movingTime: (json['moving_time'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
  startDateLocal: json['start_date_local'] as String?,
  rank: (json['rank'] as num?)?.toInt(),
);

Map<String, dynamic> _$SegmentLeaderboardEntryToJson(
  SegmentLeaderboardEntry instance,
) => <String, dynamic>{
  'athlete_name': instance.athleteName,
  'elapsed_time': instance.elapsedTime,
  'moving_time': instance.movingTime,
  'start_date': instance.startDate,
  'start_date_local': instance.startDateLocal,
  'rank': instance.rank,
};
