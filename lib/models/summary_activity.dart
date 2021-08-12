// To parse this JSON data, do
//
//     final summaryActivity = summaryActivityFromJson(jsonString);

import 'dart:convert';

class SummaryActivity {
  SummaryActivity({
    required this.resourceState,
    required this.athlete,
    required this.name,
    required this.distance,
    required this.movingTime,
    required this.elapsedTime,
    required this.totalElevationGain,
    required this.type,
    required this.workoutType,
    required this.id,
    required this.externalId,
    required this.uploadId,
    required this.startDate,
    required this.startDateLocal,
    required this.timezone,
    required this.utcOffset,
    required this.startLatlng,
    required this.endLatlng,
    required this.locationCity,
    required this.locationState,
    required this.locationCountry,
    required this.achievementCount,
    required this.kudosCount,
    required this.commentCount,
    required this.athleteCount,
    required this.photoCount,
    required this.map,
    required this.trainer,
    required this.commute,
    required this.manual,
    required this.private,
    required this.flagged,
    required this.gearId,
    required this.fromAcceptedTag,
    required this.averageSpeed,
    required this.maxSpeed,
    required this.averageCadence,
    required this.averageWatts,
    required this.weightedAverageWatts,
    required this.kilojoules,
    required this.deviceWatts,
    required this.hasHeartrate,
    required this.averageHeartrate,
    required this.maxHeartrate,
    required this.maxWatts,
    required this.prCount,
    required this.totalPhotoCount,
    required this.hasKudoed,
    required this.sufferScore,
  });

  final num resourceState;
  final Athlete athlete;
  final String name;
  final double distance;
  final num movingTime;
  final num elapsedTime;
  final num totalElevationGain;
  final String type;
  final dynamic workoutType;
  final int id;
  final String externalId;
  final double uploadId;
  final DateTime? startDate;
  final DateTime? startDateLocal;
  final String timezone;
  final num utcOffset;
  final dynamic startLatlng;
  final dynamic endLatlng;
  final dynamic locationCity;
  final dynamic locationState;
  final String locationCountry;
  final num achievementCount;
  final num kudosCount;
  final num commentCount;
  final num athleteCount;
  final num photoCount;
  final MapClass? map;
  final bool trainer;
  final bool commute;
  final bool manual;
  final bool private;
  final bool flagged;
  final String gearId;
  final bool fromAcceptedTag;
  final double averageSpeed;
  final num maxSpeed;
  final double averageCadence;
  final double averageWatts;
  final num weightedAverageWatts;
  final double kilojoules;
  final bool deviceWatts;
  final bool hasHeartrate;
  final double averageHeartrate;
  final num maxHeartrate;
  final num maxWatts;
  final num prCount;
  final num totalPhotoCount;
  final bool hasKudoed;
  final num sufferScore;

  factory SummaryActivity.fromRawJson(String str) => SummaryActivity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryActivity.fromJson(Map<String, dynamic> json) => SummaryActivity(
    resourceState: json["resource_state"],
    athlete: Athlete.fromJson(json["athlete"]),
    name: json["name"],
    distance: json["distance"],
    movingTime: json["moving_time"],
    elapsedTime: json["elapsed_time"],
    totalElevationGain: json["total_elevation_gain"],
    type: json["type"],
    workoutType: json["workout_type"],
    id: json["id"],
    externalId: json["external_id"],
    uploadId: json["upload_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    startDateLocal: json["start_date_local"] == null ? null : DateTime.parse(json["start_date_local"] ?? ""),
    timezone: json["timezone"],
    utcOffset: json["utc_offset"],
    startLatlng: json["start_latlng"],
    endLatlng: json["end_latlng"],
    locationCity: json["location_city"],
    locationState: json["location_state"],
    locationCountry: json["location_country"],
    achievementCount: json["achievement_count"],
    kudosCount: json["kudos_count"],
    commentCount: json["comment_count"],
    athleteCount: json["athlete_count"],
    photoCount: json["photo_count"],
    map: json["map"] == null ? null : MapClass.fromJson(json["map"]),
    trainer: json["trainer"],
    commute: json["commute"],
    manual: json["manual"],
    private: json["private"],
    flagged: json["flagged"],
    gearId: json["gear_id"],
    fromAcceptedTag: json["from_accepted_tag"],
    averageSpeed: json["average_speed"],
    maxSpeed: json["max_speed"],
    averageCadence: json["average_cadence"],
    averageWatts: json["average_watts"],
    weightedAverageWatts: json["weighted_average_watts"],
    kilojoules: json["kilojoules"],
    deviceWatts: json["device_watts"],
    hasHeartrate: json["has_heartrate"],
    averageHeartrate: json["average_heartrate"],
    maxHeartrate: json["max_heartrate"],
    maxWatts: json["max_watts"],
    prCount: json["pr_count"],
    totalPhotoCount: json["total_photo_count"],
    hasKudoed: json["has_kudoed"],
    sufferScore: json["suffer_score"],
  );

  Map<String, dynamic> toJson() => {
    "resource_state": resourceState,
    "athlete": athlete.toJson(),
    "name": name,
    "distance": distance,
    "moving_time": movingTime,
    "elapsed_time": elapsedTime,
    "total_elevation_gain": totalElevationGain,
    "type": type,
    "workout_type": workoutType,
    "id": id,
    "external_id": externalId,
    "upload_id": uploadId,
    "start_date": startDate?.toIso8601String(),
    "start_date_local": startDateLocal?.toIso8601String(),
    "timezone": timezone,
    "utc_offset": utcOffset,
    "start_latlng": startLatlng,
    "end_latlng": endLatlng,
    "location_city": locationCity,
    "location_state": locationState,
    "location_country": locationCountry,
    "achievement_count": achievementCount,
    "kudos_count": kudosCount,
    "comment_count": commentCount,
    "athlete_count": athleteCount,
    "photo_count": photoCount,
    "map": map?.toJson(),
    "trainer": trainer,
    "commute": commute,
    "manual": manual,
    "private": private,
    "flagged": flagged,
    "gear_id": gearId,
    "from_accepted_tag": fromAcceptedTag,
    "average_speed": averageSpeed,
    "max_speed": maxSpeed,
    "average_cadence": averageCadence,
    "average_watts": averageWatts,
    "weighted_average_watts": weightedAverageWatts,
    "kilojoules": kilojoules,
    "device_watts": deviceWatts,
    "has_heartrate": hasHeartrate,
    "average_heartrate": averageHeartrate,
    "max_heartrate": maxHeartrate,
    "max_watts": maxWatts,
    "pr_count": prCount,
    "total_photo_count": totalPhotoCount,
    "has_kudoed": hasKudoed,
    "suffer_score": sufferScore,
  };
}

class Athlete {
  Athlete({
    required this.id,
    required this.resourceState,
  });

  final num id;
  final num resourceState;

  factory Athlete.fromRawJson(String str) => Athlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Athlete.fromJson(Map<String, dynamic> json) => Athlete(
    id: json["id"],
    resourceState: json["resource_state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resource_state": resourceState,
  };
}

class MapClass {
  MapClass({
    required this.id,
    required this.summaryPolyline,
    required this.resourceState,
  });

  final String id;
  final dynamic summaryPolyline;
  final num resourceState;

  factory MapClass.fromRawJson(String str) => MapClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    id: json["id"],
    summaryPolyline: json["summary_polyline"],
    resourceState: json["resource_state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "summary_polyline": summaryPolyline,
    "resource_state": resourceState,
  };
}
