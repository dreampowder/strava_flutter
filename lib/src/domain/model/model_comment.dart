import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_summary_athlete.dart';

part 'model_comment.g.dart';

// Example of value :
// id : 12345678987654321
// activity_id : 12345678987654321
// post_id : null
// resource_state : 2
// text : "Good job and keep the cat pictures coming!"
// mentions_metadata : null
// created_at : "2018-02-08T19:25:39Z"
// athlete : {"firstname":"Peter","lastname":"S"}
@JsonSerializable()
class Comment {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "activity_id")
  int? activityId;

  @JsonKey(name: "post_id")
  int? postId;

  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "text")
  String? text;

  @JsonKey(name: "mentions_metadata")
  dynamic mentionsMetadata;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "athlete", includeIfNull: false)
  SummaryAthlete? athlete;

  Comment({
    this.id,
    this.activityId,
    this.postId,
    this.resourceState,
    this.text,
    this.mentionsMetadata,
    this.createdAt,
    this.athlete,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
