import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/model/model_summary_segment.dart';

/// id : 229781
/// resource_state : 3
/// name : "Hawk Hill"
/// activity_type : "Ride"
/// distance : 2684.82
/// average_grade : 5.7
/// maximum_grade : 14.2
/// elevation_high : 245.3
/// elevation_low : 92.4
/// start_latlng : [37.8331119,-122.4834356]
/// end_latlng : [37.8280722,-122.4981393]
/// climb_category : 1
/// city : "San Francisco"
/// state : "CA"
/// country : "United States"
/// private : false
/// hazardous : false
/// starred : false
/// created_at : "2009-09-21T20:29:41Z"
/// updated_at : "2018-02-15T09:04:18Z"
/// total_elevation_gain : 155.733
/// map : {"id":"s229781","polyline":"}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@","resource_state":3}
/// effort_count : 309974
/// athlete_count : 30623
/// star_count : 2428
/// athlete_segment_stats : {"pr_elapsed_time":553,"pr_date":"1993-04-03","effort_count":2}

class DetailedSegment {
  int? id;
  int? resourceState;
  String? name;
  String? activityType;
  double? distance;
  double? averageGrade;
  double? maximumGrade;
  double? elevationHigh;
  double? elevationLow;
  List<double>? startLatlng;
  List<double>? endLatlng;
  int? climbCategory;
  String? city;
  String? state;
  String? country;
  bool? private;
  bool? hazardous;
  bool? starred;
  String? createdAt;
  String? updatedAt;
  double? totalElevationGain;
  PolyLineMap? map;
  int? effortCount;
  int? athleteCount;
  int? starCount;
  SummaryPRSegmentEffort? athleteSegmentStats;

  DetailedSegment({
      this.id, 
      this.resourceState, 
      this.name, 
      this.activityType, 
      this.distance, 
      this.averageGrade, 
      this.maximumGrade, 
      this.elevationHigh, 
      this.elevationLow, 
      this.startLatlng, 
      this.endLatlng, 
      this.climbCategory, 
      this.city, 
      this.state, 
      this.country, 
      this.private, 
      this.hazardous, 
      this.starred, 
      this.createdAt, 
      this.updatedAt, 
      this.totalElevationGain, 
      this.map, 
      this.effortCount, 
      this.athleteCount, 
      this.starCount, 
      this.athleteSegmentStats});

  DetailedSegment.fromJson(dynamic json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activityType = json['activity_type'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    elevationHigh = json['elevation_high'];
    elevationLow = json['elevation_low'];
    startLatlng = json['start_latlng'] != null ? json['start_latlng'].cast<double>() : [];
    endLatlng = json['end_latlng'] != null ? json['end_latlng'].cast<double>() : [];
    climbCategory = json['climb_category'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    private = json['private'];
    hazardous = json['hazardous'];
    starred = json['starred'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalElevationGain = json['total_elevation_gain'];
    map = json['map'] != null ? PolyLineMap.fromJson(json['map']) : null;
    effortCount = json['effort_count'];
    athleteCount = json['athlete_count'];
    starCount = json['star_count'];
    athleteSegmentStats = json['athlete_segment_stats'] != null ? SummaryPRSegmentEffort.fromJson(json['athleteSegmentStats']) : null;
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['resource_state'] = resourceState;
    jsonMap['name'] = name;
    jsonMap['activity_type'] = activityType;
    jsonMap['distance'] = distance;
    jsonMap['average_grade'] = averageGrade;
    jsonMap['maximum_grade'] = maximumGrade;
    jsonMap['elevation_high'] = elevationHigh;
    jsonMap['elevation_low'] = elevationLow;
    jsonMap['start_latlng'] = startLatlng;
    jsonMap['end_latlng'] = endLatlng;
    jsonMap['climb_category'] = climbCategory;
    jsonMap['city'] = city;
    jsonMap['state'] = state;
    jsonMap['country'] = country;
    jsonMap['private'] = private;
    jsonMap['hazardous'] = hazardous;
    jsonMap['starred'] = starred;
    jsonMap['created_at'] = createdAt;
    jsonMap['updated_at'] = updatedAt;
    jsonMap['total_elevation_gain'] = totalElevationGain;
    if (map != null) {
      jsonMap['map'] = map?.toJson();
    }
    jsonMap['effort_count'] = effortCount;
    jsonMap['athlete_count'] = athleteCount;
    jsonMap['star_count'] = starCount;
    if (athleteSegmentStats != null) {
      jsonMap['athlete_segment_stats'] = athleteSegmentStats?.toJson();
    }
    return jsonMap;
  }

}
