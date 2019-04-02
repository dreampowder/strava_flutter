// Activity

import 'gear.dart';
import 'fault.dart';
import '../globals.dart' as globals;

class DetailedActivity {
  Fault fault;
  int id;
  int resourceState;
  String externalId;
  int uploadId;
  Athlete athlete;
  String name;
  double distance;
  int movingTime;
  int elapsedTime;
  double totalElevationGain;
  String type;
  String startDate;
  String startDateLocal;
  String timezone;
  double utcOffset;
  List<double> startLatlng;
  List<double> endLatlng;
  double startLatitude;
  double startLongitude;
  int achievementCount;
  int kudosCount;
  int commentCount;
  int athleteCount;
  int photoCount;
  Carte map;
  bool trainer;
  bool commute;
  bool manual;
  bool private;
  bool flagged;
  String gearId;
  bool fromAcceptedTag;
  double averageSpeed;
  double maxSpeed;
  double averageCadence;
  int averageTemp;
  double averageWatts;
  int weightedAverageWatts;
  double kilojoules;
  bool deviceWatts;
  bool hasHeartrate;
  int maxWatts;
  double elevHigh;
  double elevLow;
  int prCount;
  int totalPhotoCount;
  bool hasKudoed;
  int workoutType;
  int sufferScore;
  String description;
  double calories;
  List<SegmentEfforts> segmentEfforts;
  List<SplitsMetric> splitsMetric;
  List<Laps> laps;
  Gear gear;
  String partnerBrandTag;
  Photos photos;
  List<HighlightedKudosers> highlightedKudosers;
  String deviceName;
  String embedToken;
  bool segmentLeaderboardOptOut;
  bool leaderboardOptOut;

  DetailedActivity(
      {Fault fault,
      this.id,
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
      this.averageCadence,
      this.averageTemp,
      this.averageWatts,
      this.weightedAverageWatts,
      this.kilojoules,
      this.deviceWatts,
      this.hasHeartrate,
      this.maxWatts,
      this.elevHigh,
      this.elevLow,
      this.prCount,
      this.totalPhotoCount,
      this.hasKudoed,
      this.workoutType,
      this.sufferScore,
      this.description,
      this.calories,
      this.segmentEfforts,
      this.splitsMetric,
      this.laps,
      this.gear,
      this.partnerBrandTag,
      this.photos,
      this.highlightedKudosers,
      this.deviceName,
      this.embedToken,
      this.segmentLeaderboardOptOut,
      this.leaderboardOptOut})
      : fault = Fault(88, '');

  DetailedActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'] ?? 0;
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
    // startLatlng = json['start_latlng'].cast<double>();
    startLatlng = (json['start_latlng'] != null)
        ? json['start_latlng'].cast<double>()
        : [globals.defaultStartLatlng, globals.defaultEndlatlng];

    // endLatlng = json['end_latlng'].cast<double>();
    endLatlng = (json['end_latlng'] != null)
        ? json['end_latlng'].cast<double>()
        : [globals.defaultStartLatlng, globals.defaultEndlatlng];

    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    achievementCount = json['achievement_count'];
    kudosCount = json['kudos_count'];
    commentCount = json['comment_count'];
    athleteCount = json['athlete_count'];
    photoCount = json['photo_count'];
    map = json['map'] != null ? Carte.fromJson(json['map']) : null;
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
    averageTemp = json['average_temp'];
    averageWatts = json['average_watts'];
    weightedAverageWatts = json['weighted_average_watts'];
    kilojoules = json['kilojoules'];
    deviceWatts = json['device_watts'];
    hasHeartrate = json['has_heartrate'];
    maxWatts = json['max_watts'];
    elevHigh = json['elev_high'];
    elevLow = json['elev_low'];
    prCount = json['pr_count'];
    totalPhotoCount = json['total_photo_count'];
    hasKudoed = json['has_kudoed'];
    workoutType = json['workout_type'] ?? 10; //
    sufferScore = json['suffer_score'];
    description = json['description'];
    calories = (json['calories']).toDouble();
    if (json['segment_efforts'] != null) {
      segmentEfforts = new List<SegmentEfforts>();
      json['segment_efforts'].forEach((v) {
        segmentEfforts.add(new SegmentEfforts.fromJson(v));
      });
    }
    if (json['splits_metric'] != null) {
      splitsMetric = new List<SplitsMetric>();
      json['splits_metric'].forEach((v) {
        splitsMetric.add(new SplitsMetric.fromJson(v));
      });
    }
    if (json['laps'] != null) {
      laps = new List<Laps>();
      json['laps'].forEach((v) {
        laps.add(new Laps.fromJson(v));
      });
    }
    gear = json['gear'] != null ? new Gear.fromJson(json['gear']) : null;
    partnerBrandTag = json['partner_brand_tag'];
    photos =
        json['photos'] != null ? new Photos.fromJson(json['photos']) : null;
    if (json['highlighted_kudosers'] != null) {
      highlightedKudosers = new List<HighlightedKudosers>();
      json['highlighted_kudosers'].forEach((v) {
        highlightedKudosers.add(new HighlightedKudosers.fromJson(v));
      });
    }
    deviceName = json['device_name'];
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
    data['average_cadence'] = this.averageCadence;
    data['average_temp'] = this.averageTemp;
    data['average_watts'] = this.averageWatts;
    data['weighted_average_watts'] = this.weightedAverageWatts;
    data['kilojoules'] = this.kilojoules;
    data['device_watts'] = this.deviceWatts;
    data['has_heartrate'] = this.hasHeartrate;
    data['max_watts'] = this.maxWatts;
    data['elev_high'] = this.elevHigh;
    data['elev_low'] = this.elevLow;
    data['pr_count'] = this.prCount;
    data['total_photo_count'] = this.totalPhotoCount;
    data['has_kudoed'] = this.hasKudoed;
    data['workout_type'] = this.workoutType;
    data['suffer_score'] = this.sufferScore;
    data['description'] = this.description;
    data['calories'] = this.calories;
    if (this.segmentEfforts != null) {
      data['segment_efforts'] =
          this.segmentEfforts.map((v) => v.toJson()).toList();
    }
    if (this.splitsMetric != null) {
      data['splits_metric'] = this.splitsMetric.map((v) => v.toJson()).toList();
    }
    if (this.laps != null) {
      data['laps'] = this.laps.map((v) => v.toJson()).toList();
    }
    if (this.gear != null) {
      data['gear'] = this.gear.toJson();
    }
    data['partner_brand_tag'] = this.partnerBrandTag;
    if (this.photos != null) {
      data['photos'] = this.photos.toJson();
    }
    if (this.highlightedKudosers != null) {
      data['highlighted_kudosers'] =
          this.highlightedKudosers.map((v) => v.toJson()).toList();
    }
    data['device_name'] = this.deviceName;
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

class Carte {
  String id;
  String polyline;
  int resourceState;
  String summaryPolyline;

  Carte({this.id, this.polyline, this.resourceState, this.summaryPolyline});

  Carte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    polyline = json['polyline'];
    resourceState = json['resource_state'];
    summaryPolyline = json['summary_polyline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['polyline'] = this.polyline;
    data['resource_state'] = this.resourceState;
    data['summary_polyline'] = this.summaryPolyline;
    return data;
  }
}

class SegmentEfforts {
  int id;
  int resourceState;
  String name;
  Activity activity;
  Athlete athlete;
  int elapsedTime;
  int movingTime;
  String startDate;
  String startDateLocal;
  double distance;
  int startIndex;
  int endIndex;
  double averageCadence;
  bool deviceWatts;
  double averageWatts;
  Segment segment;
  int komRank;
  int prRank;

  List<String> achievements;
  bool hidden;

  SegmentEfforts(
      {this.id,
      this.resourceState,
      this.name,
      this.activity,
      this.athlete,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.distance,
      this.startIndex,
      this.endIndex,
      this.averageCadence,
      this.deviceWatts,
      this.averageWatts,
      this.segment,
      this.komRank,
      this.prRank,
      this.achievements,
      this.hidden});

  SegmentEfforts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    athlete =
        json['athlete'] != null ? new Athlete.fromJson(json['athlete']) : null;
    elapsedTime = json['elapsed_time'];
    movingTime = json['moving_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    distance = json['distance'];
    startIndex = json['start_index'];
    endIndex = json['end_index'];
    averageCadence = json['average_cadence'];
    deviceWatts = json['device_watts'];
    averageWatts = json['average_watts'];
    segment =
        json['segment'] != null ? new Segment.fromJson(json['segment']) : null;
    komRank = json['kom_rank'];
    prRank = json['pr_rank'];
    /****
    if (json['achievements'] != null) {
      achievements = new List<Null>();
      json['achievements'].forEach((v) {
        achievements.add(new Null.fromJson(v));
      });
    }
  ****/
    hidden = json['hidden'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    if (this.athlete != null) {
      data['athlete'] = this.athlete.toJson();
    }
    data['elapsed_time'] = this.elapsedTime;
    data['moving_time'] = this.movingTime;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['distance'] = this.distance;
    data['start_index'] = this.startIndex;
    data['end_index'] = this.endIndex;
    data['average_cadence'] = this.averageCadence;
    data['device_watts'] = this.deviceWatts;
    data['average_watts'] = this.averageWatts;
    if (this.segment != null) {
      data['segment'] = this.segment.toJson();
    }
    data['kom_rank'] = this.komRank;
    data['pr_rank'] = this.prRank;
    /***
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
  ****/
    data['hidden'] = this.hidden;
    return data;
  }
}

class Activity {
  int id;
  int resourceState;

  Activity({this.id, this.resourceState});

  Activity.fromJson(Map<String, dynamic> json) {
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

class Segment {
  int id;
  int resourceState;
  String name;
  String activityType;
  double distance;
  double averageGrade;
  double maximumGrade;
  double elevationHigh;
  double elevationLow;
  List<double> startLatlng;
  List<double> endLatlng;
  double startLatitude;
  double startLongitude;
  double endLatitude;
  double endLongitude;
  int climbCategory;
  String city;
  String state;
  String country;
  bool private;
  bool hazardous;
  bool starred;

  Segment(
      {this.id,
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
      this.startLatitude,
      this.startLongitude,
      this.endLatitude,
      this.endLongitude,
      this.climbCategory,
      this.city,
      this.state,
      this.country,
      this.private,
      this.hazardous,
      this.starred});

  Segment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activityType = json['activity_type'];
    distance = json['distance'];
    averageGrade = json['average_grade'];
    maximumGrade = json['maximum_grade'];
    elevationHigh = json['elevation_high'];
    elevationLow = json['elevation_low'];
    startLatlng = json['start_latlng'].cast<double>();
    endLatlng = json['end_latlng'].cast<double>();
    startLatitude = json['start_latitude'];
    startLongitude = json['start_longitude'];
    endLatitude = json['end_latitude'];
    endLongitude = json['end_longitude'];
    climbCategory = json['climb_category'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    private = json['private'];
    hazardous = json['hazardous'];
    starred = json['starred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    data['activity_type'] = this.activityType;
    data['distance'] = this.distance;
    data['average_grade'] = this.averageGrade;
    data['maximum_grade'] = this.maximumGrade;
    data['elevation_high'] = this.elevationHigh;
    data['elevation_low'] = this.elevationLow;
    data['start_latlng'] = this.startLatlng;
    data['end_latlng'] = this.endLatlng;
    data['start_latitude'] = this.startLatitude;
    data['start_longitude'] = this.startLongitude;
    data['end_latitude'] = this.endLatitude;
    data['end_longitude'] = this.endLongitude;
    data['climb_category'] = this.climbCategory;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['private'] = this.private;
    data['hazardous'] = this.hazardous;
    data['starred'] = this.starred;
    return data;
  }
}

class SplitsMetric {
  double distance;
  int elapsedTime;
  double elevationDifference;
  int movingTime;
  int split;
  double averageSpeed;
  int paceZone;

  SplitsMetric(
      {this.distance,
      this.elapsedTime,
      this.elevationDifference,
      this.movingTime,
      this.split,
      this.averageSpeed,
      this.paceZone});

  SplitsMetric.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    elapsedTime = json['elapsed_time'];
    elevationDifference = json['elevation_difference'];
    movingTime = json['moving_time'];
    split = json['split'];
    averageSpeed = json['average_speed'];
    paceZone = json['pace_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['elapsed_time'] = this.elapsedTime;
    data['elevation_difference'] = this.elevationDifference;
    data['moving_time'] = this.movingTime;
    data['split'] = this.split;
    data['average_speed'] = this.averageSpeed;
    data['pace_zone'] = this.paceZone;
    return data;
  }
}

class Laps {
  int id;
  int resourceState;
  String name;
  Activity activity;
  Athlete athlete;
  int elapsedTime;
  int movingTime;
  String startDate;
  String startDateLocal;
  double distance;
  int startIndex;
  int endIndex;
  double totalElevationGain;
  double averageSpeed;
  double maxSpeed;
  double averageCadence;
  bool deviceWatts;
  double averageWatts;
  int lapIndex;
  int split;

  Laps(
      {this.id,
      this.resourceState,
      this.name,
      this.activity,
      this.athlete,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.distance,
      this.startIndex,
      this.endIndex,
      this.totalElevationGain,
      this.averageSpeed,
      this.maxSpeed,
      this.averageCadence,
      this.deviceWatts,
      this.averageWatts,
      this.lapIndex,
      this.split});

  Laps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    athlete =
        json['athlete'] != null ? new Athlete.fromJson(json['athlete']) : null;
    elapsedTime = json['elapsed_time'];
    movingTime = json['moving_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    distance = json['distance'];
    startIndex = json['start_index'];
    endIndex = json['end_index'];
    totalElevationGain = (json['total_elevation_gain']).toDouble();
    averageSpeed = json['average_speed'];
    maxSpeed = json['max_speed'];
    averageCadence = json['average_cadence'];
    deviceWatts = json['device_watts'];
    averageWatts = json['average_watts'];
    lapIndex = json['lap_index'];
    split = json['split'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    if (this.athlete != null) {
      data['athlete'] = this.athlete.toJson();
    }
    data['elapsed_time'] = this.elapsedTime;
    data['moving_time'] = this.movingTime;
    data['start_date'] = this.startDate;
    data['start_date_local'] = this.startDateLocal;
    data['distance'] = this.distance;
    data['start_index'] = this.startIndex;
    data['end_index'] = this.endIndex;
    data['total_elevation_gain'] = this.totalElevationGain;
    data['average_speed'] = this.averageSpeed;
    data['max_speed'] = this.maxSpeed;
    data['average_cadence'] = this.averageCadence;
    data['device_watts'] = this.deviceWatts;
    data['average_watts'] = this.averageWatts;
    data['lap_index'] = this.lapIndex;
    data['split'] = this.split;
    return data;
  }
}

class Photos {
  Primary primary;
  bool usePrimaryPhoto;
  int count;

  Photos({this.primary, this.usePrimaryPhoto, this.count});

  Photos.fromJson(Map<String, dynamic> json) {
    primary =
        json['primary'] != null ? new Primary.fromJson(json['primary']) : null;
    usePrimaryPhoto = json['use_primary_photo'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.primary != null) {
      data['primary'] = this.primary.toJson();
    }
    data['use_primary_photo'] = this.usePrimaryPhoto;
    data['count'] = this.count;
    return data;
  }
}

class Primary {
  Null id;
  String uniqueId;
  Urls urls;
  int source;

  Primary({this.id, this.uniqueId, this.urls, this.source});

  Primary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    if (this.urls != null) {
      data['urls'] = this.urls.toJson();
    }
    data['source'] = this.source;
    return data;
  }
}

class Urls {
  String s100;
  String s600;

  Urls({this.s100, this.s600});

  Urls.fromJson(Map<String, dynamic> json) {
    s100 = json['100'];
    s600 = json['600'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['100'] = this.s100;
    data['600'] = this.s600;
    return data;
  }
}

class HighlightedKudosers {
  String destinationUrl;
  String displayName;
  String avatarUrl;
  bool showName;

  HighlightedKudosers(
      {this.destinationUrl, this.displayName, this.avatarUrl, this.showName});

  HighlightedKudosers.fromJson(Map<String, dynamic> json) {
    destinationUrl = json['destination_url'];
    displayName = json['display_name'];
    avatarUrl = json['avatar_url'];
    showName = json['show_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_url'] = this.destinationUrl;
    data['display_name'] = this.displayName;
    data['avatar_url'] = this.avatarUrl;
    data['show_name'] = this.showName;
    return data;
  }
}


//------------------
// Summary activity
//------------------

class SummaryActivity {
  Fault fault;
  int id;
  int resourceState;
  Athlete athlete;
  String name;
  double distance;
  int movingTime;
  int elapsedTime;
  double totalElevationGain;
  String type;
  int workoutType;

  SummaryActivity(
      {this.id,
      this.resourceState,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.workoutType});

  SummaryActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    athlete =
        json['athlete'] != null ? Athlete.fromJson(json['athlete']) : null;
    name = json['name'];
    distance = json['distance'];
    movingTime = json['moving_time'];
    elapsedTime = json['elapsed_time'];
    totalElevationGain = json['total_elevation_gain'];
    type = json['type'];
    workoutType = json['workout_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    if (this.athlete != null) {
      data['athlete'] = this.athlete.toJson();
    }
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['moving_time'] = this.movingTime;
    data['elapsed_time'] = this.elapsedTime;
    data['total_elevation_gain'] = this.totalElevationGain;
    data['type'] = this.type;
    data['workout_type'] = this.workoutType;
    return data;
  }
}


/****
class Athlete {
  int resourceState;
  String firstname;
  String lastname;

  Athlete({this.resourceState, this.firstname, this.lastname});

  Athlete.fromJson(Map<String, dynamic> json) {
    resourceState = json['resource_state'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resource_state'] = this.resourceState;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
***/

