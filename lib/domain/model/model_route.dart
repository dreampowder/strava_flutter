import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/model/model_summary_athlete.dart';
import 'package:strava_flutter/domain/model/model_summary_segment.dart';

/// private : true
/// distance : 0.8008282
/// athlete : ""
/// description : "aeiou"
/// created_at : "2000-01-23T04:56:07.000+00:00"
/// elevation_gain : 6.0274563
/// type : 5
/// estimated_moving_time : 7
/// segments : [{"country":"aeiou","private":true,"distance":3.6160767,"average_grade":2.027123,"maximum_grade":4.145608,"climb_category":1,"city":"aeiou","elevation_high":7.386282,"athlete_pr_effort":{"distance":1.1730742,"start_date_local":"2000-01-23T04:56:07.000+00:00","activity_id":6,"elapsed_time":7,"is_kom":true,"id":1,"start_date":"2000-01-23T04:56:07.000+00:00"},"athlete_segment_stats":{"pr_elapsed_time":5,"pr_date":"2000-01-23T04:56:07.000+00:00","effort_count":9,"pr_activity_id":4},"start_latlng":"","elevation_low":1.2315135,"end_latlng":"","activity_type":"Ride","name":"aeiou","id":9,"state":"aeiou"}]
/// starred : true
/// updated_at : "2000-01-23T04:56:07.000+00:00"
/// sub_type : 2
/// id_str : "aeiou"
/// name : "aeiou"
/// id : 1
/// map : {"summary_polyline":"aeiou","id":"aeiou","polyline":"aeiou"}
/// timestamp : 5

class Route {
  bool? private;
  double? distance;
  SummaryAthlete? athlete;
  String? description;
  String? createdAt;
  double? elevationGain;
  int? type;
  int? estimatedMovingTime;
  List<SummarySegment>? segments;
  bool? starred;
  String? updatedAt;
  int? subType;
  String? idStr;
  String? name;
  int? id;
  PolyLineMap? map;
  int? timestamp;

  Route({
      this.private, 
      this.distance, 
      this.athlete, 
      this.description, 
      this.createdAt, 
      this.elevationGain, 
      this.type, 
      this.estimatedMovingTime, 
      this.segments, 
      this.starred, 
      this.updatedAt, 
      this.subType, 
      this.idStr, 
      this.name, 
      this.id, 
      this.map, 
      this.timestamp});

  Route.fromJson(dynamic json) {
    private = json['private'];
    distance = json['distance'];
    athlete = json['athlete'] != null ? SummaryAthlete.fromJson(json['athlete']) : null;
    description = json['description'];
    createdAt = json['created_at'];
    elevationGain = json['elevation_gain'];
    type = json['type'];
    estimatedMovingTime = json['estimated_moving_time'];
    if (json['segments'] != null) {
      segments = [];
      json['segments'].forEach((v) {
        segments?.add(SummarySegment.fromJson(v));
      });
    }
    starred = json['starred'];
    updatedAt = json['updated_at'];
    subType = json['sub_type'];
    idStr = json['id_str'];
    name = json['name'];
    id = json['id'];
    map = json['map'] != null ? PolyLineMap.fromJson(json['map']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['private'] = private;
    jsonMap['distance'] = distance;
    jsonMap['athlete'] = athlete?.toJson();
    jsonMap['description'] = description;
    jsonMap['created_at'] = createdAt;
    jsonMap['elevation_gain'] = elevationGain;
    jsonMap['type'] = type;
    jsonMap['estimated_moving_time'] = estimatedMovingTime;
    if (segments != null) {
      jsonMap['segments'] = segments?.map((v) => v.toJson()).toList();
    }
    jsonMap['starred'] = starred;
    jsonMap['updated_at'] = updatedAt;
    jsonMap['sub_type'] = subType;
    jsonMap['id_str'] = idStr;
    jsonMap['name'] = name;
    jsonMap['id'] = id;
    jsonMap['map'] = map?.toJson();
    jsonMap['timestamp'] = timestamp;
    return jsonMap;
  }

}

