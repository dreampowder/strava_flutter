import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/model/model_lap.dart';

/// resource_state : 2
/// athlete : {"id":134815,"resource_state":1}
/// name : "Happy Friday"
/// distance : 24931.4
/// moving_time : 4500
/// elapsed_time : 4500
/// total_elevation_gain : 0
/// type : "Ride"
/// workout_type : null
/// id : 154504250376823
/// external_id : "garmin_push_12345678987654321"
/// upload_id : 987654321234567891234
/// start_date : "2018-05-02T12:15:09Z"
/// start_date_local : "2018-05-02T05:15:09Z"
/// timezone : "(GMT-08:00) America/Los_Angeles"
/// utc_offset : -25200
/// start_latlng : null
/// end_latlng : null
/// location_city : null
/// location_state : null
/// location_country : "United States"
/// achievement_count : 0
/// kudos_count : 3
/// comment_count : 1
/// athlete_count : 1
/// photo_count : 0
/// map : {"id":"a12345678987654321","summary_polyline":null,"resource_state":2}
/// trainer : true
/// commute : false
/// manual : false
/// private : false
/// flagged : false
/// gear_id : "b12345678987654321"
/// from_accepted_tag : false
/// average_speed : 5.54
/// max_speed : 11
/// average_cadence : 67.1
/// average_watts : 175.3
/// weighted_average_watts : 210
/// kilojoules : 788.7
/// device_watts : true
/// has_heartrate : true
/// average_heartrate : 140.3
/// max_heartrate : 178
/// max_watts : 406
/// pr_count : 0
/// total_photo_count : 1
/// has_kudoed : false
/// suffer_score : 82

class SummaryActivity {
  int? resourceState;
  MetaAthlete? athlete;
  String? name;
  double? distance;
  int? movingTime;
  int? elapsedTime;
  double? totalElevationGain;
  String? type;
  int? workoutType;
  int? id;
  String? externalId;
  int? uploadId;
  String? startDate;
  String? startDateLocal;
  String? timezone;
  double? utcOffset;
  List<double>? startLatlng;
  List<double>? endLatlng;
  String? locationCity;
  String? locationState;
  String? locationCountry;
  int? achievementCount;
  int? kudosCount;
  int? commentCount;
  int? athleteCount;
  int? photoCount;
  PolyLineMap? map;
  bool? trainer;
  bool? commute;
  bool? manual;
  bool? private;
  bool? flagged;
  String? gearId;
  bool? fromAcceptedTag;
  double? averageSpeed;
  double? maxSpeed;
  double? averageCadence;
  double? averageWatts;
  int? weightedAverageWatts;
  double? kilojoules;
  bool? deviceWatts;
  bool? hasHeartrate;
  double? averageHeartrate;
  double? maxHeartrate;
  int? maxWatts;
  int? prCount;
  int? totalPhotoCount;
  bool? hasKudoed;
  double? sufferScore;

  SummaryActivity(
      {this.resourceState,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.workoutType,
      this.id,
      this.externalId,
      this.uploadId,
      this.startDate,
      this.startDateLocal,
      this.timezone,
      this.utcOffset,
      this.startLatlng,
      this.endLatlng,
      this.locationCity,
      this.locationState,
      this.locationCountry,
      this.achievementCount,
      this.kudosCount,
      this.commentCount,
      this.athleteCount,
      this.photoCount,
      this.map,
      this.trainer,
      this.commute,
      this.manual,
      this.private,
      this.flagged,
      this.gearId,
      this.fromAcceptedTag,
      this.averageSpeed,
      this.maxSpeed,
      this.averageCadence,
      this.averageWatts,
      this.weightedAverageWatts,
      this.kilojoules,
      this.deviceWatts,
      this.hasHeartrate,
      this.averageHeartrate,
      this.maxHeartrate,
      this.maxWatts,
      this.prCount,
      this.totalPhotoCount,
      this.hasKudoed,
      this.sufferScore});

  SummaryActivity.fromJson(dynamic json) {
    resourceState = json['resource_state'];
    athlete =
        json['athlete'] != null ? MetaAthlete.fromJson(json['athlete']) : null;
    name = json['name'];
    distance = json['distance'];
    movingTime = json['moving_time'];
    elapsedTime = json['elapsed_time'];
    totalElevationGain = json['total_elevation_gain'].toDouble();
    type = json['type'];
    workoutType = json['workout_type'];
    id = json['id'];
    externalId = json['external_id'];
    uploadId = json['upload_id'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    timezone = json['timezone'];
    utcOffset = json['utc_offset'];
    startLatlng = (json['start_latlng'] != null)
        ? json['start_latlng'].cast<double>()
        : [];
    endLatlng =
        (json['end_latlng'] != null) ? json['end_latlng'].cast<double>() : [];
    locationCity = json['location_city'];
    locationState = json['location_state'];
    locationCountry = json['location_country'];
    achievementCount = json['achievement_count'];
    kudosCount = json['kudos_count'];
    commentCount = json['comment_count'];
    athleteCount = json['athlete_count'];
    photoCount = json['photo_count'];
    map = json['map'] != null ? PolyLineMap.fromJson(json['map']) : null;
    trainer = json['trainer'];
    commute = json['commute'];
    manual = json['manual'];
    private = json['private'];
    flagged = json['flagged'];
    gearId = json['gear_id'];
    fromAcceptedTag = json['from_accepted_tag'];
    averageSpeed = json['average_speed'];
    maxSpeed = json['max_speed'];
    averageCadence = json['average_cadence'];
    averageWatts = json['average_watts'];
    weightedAverageWatts = json['weighted_average_watts'];
    kilojoules = json['kilojoules'];
    deviceWatts = json['device_watts'];
    hasHeartrate = json['has_heartrate'];
    averageHeartrate = json['average_heartrate'];
    maxHeartrate = json['max_heartrate'];
    maxWatts = json['max_watts'];
    prCount = json['pr_count'];
    totalPhotoCount = json['total_photo_count'];
    hasKudoed = json['has_kudoed'];
    sufferScore = json['suffer_score'];
  }

  Map<String, dynamic> toJson() {
    var jsonMap = <String, dynamic>{};
    jsonMap['resource_state'] = resourceState;
    if (athlete != null) {
      jsonMap['athlete'] = athlete?.toJson();
    }
    jsonMap['name'] = name;
    jsonMap['distance'] = distance;
    jsonMap['moving_time'] = movingTime;
    jsonMap['elapsed_time'] = elapsedTime;
    jsonMap['total_elevation_gain'] = totalElevationGain;
    jsonMap['type'] = type;
    jsonMap['workout_type'] = workoutType;
    jsonMap['id'] = id;
    jsonMap['external_id'] = externalId;
    jsonMap['upload_id'] = uploadId;
    jsonMap['start_date'] = startDate;
    jsonMap['start_date_local'] = startDateLocal;
    jsonMap['timezone'] = timezone;
    jsonMap['utc_offset'] = utcOffset;
    jsonMap['start_latlng'] = startLatlng;
    jsonMap['end_latlng'] = endLatlng;
    jsonMap['location_city'] = locationCity;
    jsonMap['location_state'] = locationState;
    jsonMap['location_country'] = locationCountry;
    jsonMap['achievement_count'] = achievementCount;
    jsonMap['kudos_count'] = kudosCount;
    jsonMap['comment_count'] = commentCount;
    jsonMap['athlete_count'] = athleteCount;
    jsonMap['photo_count'] = photoCount;
    if (map != null) {
      jsonMap['map'] = map?.toJson();
    }
    jsonMap['trainer'] = trainer;
    jsonMap['commute'] = commute;
    jsonMap['manual'] = manual;
    jsonMap['private'] = private;
    jsonMap['flagged'] = flagged;
    jsonMap['gear_id'] = gearId;
    jsonMap['from_accepted_tag'] = fromAcceptedTag;
    jsonMap['average_speed'] = averageSpeed;
    jsonMap['max_speed'] = maxSpeed;
    jsonMap['average_cadence'] = averageCadence;
    jsonMap['average_watts'] = averageWatts;
    jsonMap['weighted_average_watts'] = weightedAverageWatts;
    jsonMap['kilojoules'] = kilojoules;
    jsonMap['device_watts'] = deviceWatts;
    jsonMap['has_heartrate'] = hasHeartrate;
    jsonMap['average_heartrate'] = averageHeartrate;
    jsonMap['max_heartrate'] = maxHeartrate;
    jsonMap['max_watts'] = maxWatts;
    jsonMap['pr_count'] = prCount;
    jsonMap['total_photo_count'] = totalPhotoCount;
    jsonMap['has_kudoed'] = hasKudoed;
    jsonMap['suffer_score'] = sufferScore;
    return jsonMap;
  }
}
