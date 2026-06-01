// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_summary_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryPRSegmentEffort _$SummaryPRSegmentEffortFromJson(
  Map<String, dynamic> json,
) => SummaryPRSegmentEffort(
  prElapsedTime: (json['pr_elapsed_time'] as num?)?.toInt(),
  prDate: json['pr_date'] as String?,
  effortCount: (json['effort_count'] as num?)?.toInt(),
  prActivityId: (json['pr_activity_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$SummaryPRSegmentEffortToJson(
  SummaryPRSegmentEffort instance,
) => <String, dynamic>{
  'pr_elapsed_time': instance.prElapsedTime,
  'pr_date': instance.prDate,
  'effort_count': instance.effortCount,
  'pr_activity_id': instance.prActivityId,
};

SummarySegmentEffort _$SummarySegmentEffortFromJson(
  Map<String, dynamic> json,
) => SummarySegmentEffort(
  distance: (json['distance'] as num?)?.toDouble(),
  startDateLocal: json['start_date_local'] as String?,
  activityId: (json['activity_id'] as num?)?.toInt(),
  elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
  isKom: json['is_kom'] as bool?,
  id: (json['id'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
);

Map<String, dynamic> _$SummarySegmentEffortToJson(
  SummarySegmentEffort instance,
) => <String, dynamic>{
  'distance': instance.distance,
  'start_date_local': instance.startDateLocal,
  'activity_id': instance.activityId,
  'elapsed_time': instance.elapsedTime,
  'is_kom': instance.isKom,
  'id': instance.id,
  'start_date': instance.startDate,
};
