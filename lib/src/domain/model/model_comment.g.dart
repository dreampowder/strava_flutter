// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  id: (json['id'] as num?)?.toInt(),
  activityId: (json['activity_id'] as num?)?.toInt(),
  postId: (json['post_id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
  text: json['text'] as String?,
  mentionsMetadata: json['mentions_metadata'],
  createdAt: json['created_at'] as String?,
  athlete: json['athlete'] == null
      ? null
      : SummaryAthlete.fromJson(json['athlete'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'id': instance.id,
  'activity_id': instance.activityId,
  'post_id': instance.postId,
  'resource_state': instance.resourceState,
  'text': instance.text,
  'mentions_metadata': instance.mentionsMetadata,
  'created_at': instance.createdAt,
  'athlete': ?instance.athlete?.toJson(),
};
