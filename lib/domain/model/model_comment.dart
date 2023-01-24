import 'package:strava_client/domain/model/model_summary_athlete.dart';

/// id : 12345678987654321
/// activity_id : 12345678987654321
/// post_id : null
/// resource_state : 2
/// text : "Good job and keep the cat pictures coming!"
/// mentions_metadata : null
/// created_at : "2018-02-08T19:25:39Z"
/// athlete : {"firstname":"Peter","lastname":"S"}

class Comment {
  int? id;
  int? activityId;
  int? postId;
  int? resourceState;
  String? text;
  dynamic mentionsMetadata;
  String? createdAt;
  SummaryAthlete? athlete;

  Comment({
      this.id, 
      this.activityId, 
      this.postId, 
      this.resourceState, 
      this.text, 
      this.mentionsMetadata, 
      this.createdAt, 
      this.athlete});

  Comment.fromJson(dynamic json) {
    id = json['id'];
    activityId = json['activity_id'];
    postId = json['post_id'];
    resourceState = json['resource_state'];
    text = json['text'];
    mentionsMetadata = json['mentions_metadata'];
    createdAt = json['created_at'];
    athlete = json['athlete'] != null ? SummaryAthlete.fromJson(json['athlete']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['activity_id'] = activityId;
    map['post_id'] = postId;
    map['resource_state'] = resourceState;
    map['text'] = text;
    map['mentions_metadata'] = mentionsMetadata;
    map['created_at'] = createdAt;
    if (athlete != null) {
      map['athlete'] = athlete?.toJson();
    }
    return map;
  }

}

