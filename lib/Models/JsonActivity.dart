//  Activty


/****

class Activity {
  int id;
  int resourceState;
  Null externalId;
  Null uploadId;
  Athlete athlete;
  String name;
  int distance;
  int movingTime;
  int elapsedTime;
  int totalElevationGain;
  String type;
  String startDate;
  String startDateLocal;
  String timezone;
  int utcOffset;
  Null startLatlng;
  Null endLatlng;
  Null locationCity;
  Null locationState;
  String locationCountry;
  Null startLatitude;
  Null startLongitude;
  int achievementCount;
  int kudosCount;
  int commentCount;
  int athleteCount;
  int photoCount;
  Map map;
  bool trainer;
  bool commute;
  bool manual;
  bool private;
  bool flagged;
  String gearId;
  String fromAcceptedTag;
  int averageSpeed;
  int maxSpeed;
  bool deviceWatts;
  bool hasHeartrate;
  int prCount;
  int totalPhotoCount;
  bool hasKudoed;
  String workoutType;
  String description;
  int calories;
  List<String> segmentEfforts;
  String partnerBrandTag;
  List<String> highlightedKudosers;
  String embedToken;
  bool segmentLeaderboardOptOut;
  bool leaderboardOptOut;

  Activity(
      {this.id,
      this.resourceState,
      this.externalId,
      this.uploadId,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.startDate,
      this.startDateLocal,
      this.timezone,
      this.utcOffset,
      this.startLatlng,
      this.endLatlng,
      this.locationCity,
      this.locationState,
      this.locationCountry,
      this.startLatitude,
      this.startLongitude,
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
      this.deviceWatts,
      this.hasHeartrate,
      this.prCount,
      this.totalPhotoCount,
      this.hasKudoed,
      this.workoutType,
      this.description,
      this.calories,
      this.segmentEfforts,
      this.partnerBrandTag,
      this.highlightedKudosers,
      this.embedToken,
      this.segmentLeaderboardOptOut,
      this.leaderboardOptOut});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    externalId = json['external_id'];
    uploadId = json['upload_id'];
    athlete =
        json['athlete'] != null ? new Athlete.fromJson(json['athlete']) : null;
    name = json['name'];
    distance = json['distance'];
    movingTime = json['moving_time'];
    elapsedTime = json['elapsed_time'];
    totalElevationGain = json['total_elevation_gain'];
    type = json['type'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    timezone = json['timezone'];
    utcOffset = json['utc_offset'];
    startLatlng = json['start_latlng'];
    endLatlng = json['end_latlng'];
    locationCity = json['location_city'];
    locationState = json['location_state'];
    locationCountry = json['location_country'];
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    achievementCount = json['achievement_count'];
    kudosCount = json['kudos_count'];
    commentCount = json['comment_count'];
    athleteCount = json['athlete_count'];
    photoCount = json['photo_count'];
    map = json['map'] != null ? new Map.fromJson(json['map']) : null;
    trainer = json['trainer'];
    commute = json['commute'];
    manual = json['manual'];
    private = json['private'];
    flagged = json['flagged'];
    gearId = json['gear_id'];
    fromAcceptedTag = json['from_accepted_tag'];
    averageSpeed = json['average_speed'];
    maxSpeed = json['max_speed'];
    deviceWatts = json['device_watts'];
    hasHeartrate = json['has_heartrate'];
    prCount = json['pr_count'];
    totalPhotoCount = json['total_photo_count'];
    hasKudoed = json['has_kudoed'];
    workoutType = json['workout_type'];
    description = json['description'];
    calories = json['calories'];
    if (json['segment_efforts'] != null) {
      segmentEfforts = new List<String>();
      json['segment_efforts'].forEach((v) {
        segmentEfforts.add(new Null.fromJson(v));
      });
    }
    partnerBrandTag = json['partner_brand_tag'];
    if (json['highlighted_kudosers'] != null) {
      highlightedKudosers = new List<String>();
      json['highlighted_kudosers'].forEach((v) {
        highlightedKudosers.add(new Null.fromJson(v));
      });
    }
    embedToken = json['embed_token'];
    segmentLeaderboardOptOut = json['segment_leaderboard_opt_out'];
    leaderboardOptOut = json['leaderboard_opt_out'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['external_id'] = this.externalId;
    data['upload_id'] = this.uploadId;
    if (this.athlete != null) {
      data['athlete'] = this.athlete.toJson();
    }
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['moving_time'] = this.movingTime;
    data['elapsed_time'] = this.elapsedTime;
    data['total_elevation_gain'] = this.totalElevationGain;
    data['type'] = this.type;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['timezone'] = this.timezone;
    data['utc_offset'] = this.utcOffset;
    data['start_latlng'] = this.startLatlng;
    data['end_latlng'] = this.endLatlng;
    data['location_city'] = this.locationCity;
    data['location_state'] = this.locationState;
    data['location_country'] = this.locationCountry;
    data['start_latitude'] = this.startLatitude;
    data['start_longitude'] = this.startLongitude;
    data['achievement_count'] = this.achievementCount;
    data['kudos_count'] = this.kudosCount;
    data['comment_count'] = this.commentCount;
    data['athlete_count'] = this.athleteCount;
    data['photo_count'] = this.photoCount;
    if (this.map != null) {
      data['map'] = this.map.toJson();
    }
    data['trainer'] = this.trainer;
    data['commute'] = this.commute;
    data['manual'] = this.manual;
    data['private'] = this.private;
    data['flagged'] = this.flagged;
    data['gear_id'] = this.gearId;
    data['from_accepted_tag'] = this.fromAcceptedTag;
    data['average_speed'] = this.averageSpeed;
    data['max_speed'] = this.maxSpeed;
    data['device_watts'] = this.deviceWatts;
    data['has_heartrate'] = this.hasHeartrate;
    data['pr_count'] = this.prCount;
    data['total_photo_count'] = this.totalPhotoCount;
    data['has_kudoed'] = this.hasKudoed;
    data['workout_type'] = this.workoutType;
    data['description'] = this.description;
    data['calories'] = this.calories;
    if (this.segmentEfforts != null) {
      data['segment_efforts'] =
          this.segmentEfforts.map((v) => v.toJson()).toList();
    }
    data['partner_brand_tag'] = this.partnerBrandTag;
    if (this.highlightedKudosers != null) {
      data['highlighted_kudosers'] =
          this.highlightedKudosers.map((v) => v.toJson()).toList();
    }
    data['embed_token'] = this.embedToken;
    data['segment_leaderboard_opt_out'] = this.segmentLeaderboardOptOut;
    data['leaderboard_opt_out'] = this.leaderboardOptOut;
    return data;
  }
}

class Athlete {
  int id;
  int resourceState;

  Athlete({this.id, this.resourceState});

  Athlete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    return data;
  }
}

class Map {
  String id;
  Null polyline;
  int resourceState;

  Map({this.id, this.polyline, this.resourceState});

  Map.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    polyline = json['polyline'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['polyline'] = this.polyline;
    data['resource_state'] = this.resourceState;
    return data;
  }
}
*****/