// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_detailed_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedActivity _$DetailedActivityFromJson(Map<String, dynamic> json) =>
    DetailedActivity(
      id: (json['id'] as num?)?.toInt(),
      resourceState: (json['resource_state'] as num?)?.toInt(),
      externalId: json['external_id'] as String?,
      uploadId: (json['upload_id'] as num?)?.toInt(),
      athlete: json['athlete'] == null
          ? null
          : MetaAthlete.fromJson(json['athlete'] as Map<String, dynamic>),
      name: json['name'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      movingTime: (json['moving_time'] as num?)?.toInt(),
      elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
      totalElevationGain: (json['total_elevation_gain'] as num?)?.toDouble(),
      type: json['type'] as String?,
      startDate: json['start_date'] as String?,
      startDateLocal: json['start_date_local'] as String?,
      timezone: json['timezone'] as String?,
      utcOffset: (json['utc_offset'] as num?)?.toDouble(),
      startLatlng: _latLngFromJson(json['start_latlng']),
      endLatlng: _latLngFromJson(json['end_latlng']),
      achievementCount: (json['achievement_count'] as num?)?.toInt(),
      kudosCount: (json['kudos_count'] as num?)?.toInt(),
      commentCount: (json['comment_count'] as num?)?.toInt(),
      athleteCount: (json['athlete_count'] as num?)?.toInt(),
      photoCount: (json['photo_count'] as num?)?.toInt(),
      map: json['map'] == null
          ? null
          : PolyLineMap.fromJson(json['map'] as Map<String, dynamic>),
      trainer: json['trainer'] as bool?,
      commute: json['commute'] as bool?,
      manual: json['manual'] as bool?,
      private: json['private'] as bool?,
      flagged: json['flagged'] as bool?,
      gearId: json['gear_id'] as String?,
      fromAcceptedTag: json['from_accepted_tag'] as bool?,
      averageSpeed: (json['average_speed'] as num?)?.toDouble(),
      maxSpeed: (json['max_speed'] as num?)?.toDouble(),
      averageCadence: (json['average_cadence'] as num?)?.toDouble(),
      averageTemp: (json['average_temp'] as num?)?.toInt(),
      averageWatts: (json['average_watts'] as num?)?.toDouble(),
      weightedAverageWatts: (json['weighted_average_watts'] as num?)?.toInt(),
      kilojoules: (json['kilojoules'] as num?)?.toDouble(),
      deviceWatts: json['device_watts'] as bool?,
      hasHeartrate: json['has_heartrate'] as bool?,
      maxWatts: (json['max_watts'] as num?)?.toInt(),
      elevHigh: (json['elev_high'] as num?)?.toDouble(),
      elevLow: (json['elev_low'] as num?)?.toDouble(),
      prCount: (json['pr_count'] as num?)?.toInt(),
      totalPhotoCount: (json['total_photo_count'] as num?)?.toInt(),
      hasKudoed: json['has_kudoed'] as bool?,
      workoutType: (json['workout_type'] as num?)?.toInt(),
      sufferScore: json['suffer_score'] as num?,
      description: json['description'] as String?,
      calories: (json['calories'] as num?)?.toDouble(),
      segmentEfforts: (json['segment_efforts'] as List<dynamic>?)
          ?.map(
            (e) => DetailedSegmentEffort.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      splitsMetric: (json['splits_metric'] as List<dynamic>?)
          ?.map((e) => SplitsMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      laps: (json['laps'] as List<dynamic>?)
          ?.map((e) => Lap.fromJson(e as Map<String, dynamic>))
          .toList(),
      gear: json['gear'] == null
          ? null
          : SummaryGear.fromJson(json['gear'] as Map<String, dynamic>),
      partnerBrandTag: json['partner_brand_tag'],
      photos: json['photos'] == null
          ? null
          : PhotosSummary.fromJson(json['photos'] as Map<String, dynamic>),
      highlightedKudosers: (json['highlighted_kudosers'] as List<dynamic>?)
          ?.map((e) => HighlightedKudosers.fromJson(e as Map<String, dynamic>))
          .toList(),
      deviceName: json['device_name'] as String?,
      embedToken: json['embed_token'] as String?,
      segmentLeaderboardOptOut: json['segment_leaderboard_opt_out'] as bool?,
      leaderboardOptOut: json['leaderboard_opt_out'] as bool?,
    );

Map<String, dynamic> _$DetailedActivityToJson(
  DetailedActivity instance,
) => <String, dynamic>{
  'id': instance.id,
  'resource_state': instance.resourceState,
  'external_id': instance.externalId,
  'upload_id': instance.uploadId,
  'athlete': ?instance.athlete?.toJson(),
  'name': instance.name,
  'distance': instance.distance,
  'moving_time': instance.movingTime,
  'elapsed_time': instance.elapsedTime,
  'total_elevation_gain': instance.totalElevationGain,
  'type': instance.type,
  'start_date': instance.startDate,
  'start_date_local': instance.startDateLocal,
  'timezone': instance.timezone,
  'utc_offset': instance.utcOffset,
  'start_latlng': instance.startLatlng,
  'end_latlng': instance.endLatlng,
  'achievement_count': instance.achievementCount,
  'kudos_count': instance.kudosCount,
  'comment_count': instance.commentCount,
  'athlete_count': instance.athleteCount,
  'photo_count': instance.photoCount,
  'map': ?instance.map?.toJson(),
  'trainer': instance.trainer,
  'commute': instance.commute,
  'manual': instance.manual,
  'private': instance.private,
  'flagged': instance.flagged,
  'gear_id': instance.gearId,
  'from_accepted_tag': instance.fromAcceptedTag,
  'average_speed': instance.averageSpeed,
  'max_speed': instance.maxSpeed,
  'average_cadence': instance.averageCadence,
  'average_temp': instance.averageTemp,
  'average_watts': instance.averageWatts,
  'weighted_average_watts': instance.weightedAverageWatts,
  'kilojoules': instance.kilojoules,
  'device_watts': instance.deviceWatts,
  'has_heartrate': instance.hasHeartrate,
  'max_watts': instance.maxWatts,
  'elev_high': instance.elevHigh,
  'elev_low': instance.elevLow,
  'pr_count': instance.prCount,
  'total_photo_count': instance.totalPhotoCount,
  'has_kudoed': instance.hasKudoed,
  'workout_type': instance.workoutType,
  'suffer_score': instance.sufferScore,
  'description': instance.description,
  'calories': instance.calories,
  'segment_efforts': ?instance.segmentEfforts?.map((e) => e.toJson()).toList(),
  'splits_metric': ?instance.splitsMetric?.map((e) => e.toJson()).toList(),
  'laps': ?instance.laps?.map((e) => e.toJson()).toList(),
  'gear': ?instance.gear?.toJson(),
  'partner_brand_tag': instance.partnerBrandTag,
  'photos': ?instance.photos?.toJson(),
  'highlighted_kudosers': ?instance.highlightedKudosers
      ?.map((e) => e.toJson())
      .toList(),
  'device_name': instance.deviceName,
  'embed_token': instance.embedToken,
  'segment_leaderboard_opt_out': instance.segmentLeaderboardOptOut,
  'leaderboard_opt_out': instance.leaderboardOptOut,
};

HighlightedKudosers _$HighlightedKudosersFromJson(Map<String, dynamic> json) =>
    HighlightedKudosers(
      destinationUrl: json['destination_url'] as String?,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      showName: json['show_name'] as bool?,
    );

Map<String, dynamic> _$HighlightedKudosersToJson(
  HighlightedKudosers instance,
) => <String, dynamic>{
  'destination_url': instance.destinationUrl,
  'display_name': instance.displayName,
  'avatar_url': instance.avatarUrl,
  'show_name': instance.showName,
};

PhotosSummary _$PhotosSummaryFromJson(Map<String, dynamic> json) =>
    PhotosSummary(
      primary: json['primary'] == null
          ? null
          : PhotosSummaryPrimary.fromJson(
              json['primary'] as Map<String, dynamic>,
            ),
      usePrimaryPhoto: json['use_primary_photo'] as bool?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PhotosSummaryToJson(PhotosSummary instance) =>
    <String, dynamic>{
      'primary': ?instance.primary?.toJson(),
      'use_primary_photo': instance.usePrimaryPhoto,
      'count': instance.count,
    };

PhotosSummaryPrimary _$PhotosSummaryPrimaryFromJson(
  Map<String, dynamic> json,
) => PhotosSummaryPrimary(
  id: (json['id'] as num?)?.toInt(),
  uniqueId: json['unique_id'] as String?,
  urls: json['urls'] == null ? null : ActivityUrls.fromJson(json['urls']),
  source: (json['source'] as num?)?.toInt(),
);

Map<String, dynamic> _$PhotosSummaryPrimaryToJson(
  PhotosSummaryPrimary instance,
) => <String, dynamic>{
  'id': instance.id,
  'unique_id': instance.uniqueId,
  'urls': ?instance.urls?.toJson(),
  'source': instance.source,
};

SplitsMetric _$SplitsMetricFromJson(Map<String, dynamic> json) => SplitsMetric(
  distance: (json['distance'] as num?)?.toDouble(),
  elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
  elevationDifference: (json['elevation_difference'] as num?)?.toDouble(),
  movingTime: (json['moving_time'] as num?)?.toInt(),
  split: (json['split'] as num?)?.toInt(),
  averageSpeed: (json['average_speed'] as num?)?.toDouble(),
  paceZone: (json['pace_zone'] as num?)?.toInt(),
);

Map<String, dynamic> _$SplitsMetricToJson(SplitsMetric instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'elapsed_time': instance.elapsedTime,
      'elevation_difference': instance.elevationDifference,
      'moving_time': instance.movingTime,
      'split': instance.split,
      'average_speed': instance.averageSpeed,
      'pace_zone': instance.paceZone,
    };

DetailedSegmentEffort _$DetailedSegmentEffortFromJson(
  Map<String, dynamic> json,
) => DetailedSegmentEffort(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
  name: json['name'] as String?,
  activity: json['activity'] == null
      ? null
      : MetaActivity.fromJson(json['activity'] as Map<String, dynamic>),
  athlete: json['athlete'] == null
      ? null
      : MetaAthlete.fromJson(json['athlete'] as Map<String, dynamic>),
  elapsedTime: (json['elapsed_time'] as num?)?.toInt(),
  movingTime: (json['moving_time'] as num?)?.toInt(),
  startDate: json['start_date'] as String?,
  startDateLocal: json['start_date_local'] as String?,
  distance: (json['distance'] as num?)?.toDouble(),
  startIndex: (json['start_index'] as num?)?.toInt(),
  endIndex: (json['end_index'] as num?)?.toInt(),
  averageCadence: (json['average_cadence'] as num?)?.toDouble(),
  deviceWatts: json['device_watts'] as bool?,
  averageWatts: (json['average_watts'] as num?)?.toDouble(),
  segment: json['segment'] == null
      ? null
      : Segment.fromJson(json['segment'] as Map<String, dynamic>),
  komRank: (json['kom_rank'] as num?)?.toInt(),
  prRank: (json['pr_rank'] as num?)?.toInt(),
  achievements: json['achievements'] as List<dynamic>?,
  hidden: json['hidden'] as bool?,
);

Map<String, dynamic> _$DetailedSegmentEffortToJson(
  DetailedSegmentEffort instance,
) => <String, dynamic>{
  'id': instance.id,
  'resource_state': instance.resourceState,
  'name': instance.name,
  'activity': ?instance.activity?.toJson(),
  'athlete': ?instance.athlete?.toJson(),
  'elapsed_time': instance.elapsedTime,
  'moving_time': instance.movingTime,
  'start_date': instance.startDate,
  'start_date_local': instance.startDateLocal,
  'distance': instance.distance,
  'start_index': instance.startIndex,
  'end_index': instance.endIndex,
  'average_cadence': instance.averageCadence,
  'device_watts': instance.deviceWatts,
  'average_watts': instance.averageWatts,
  'segment': ?instance.segment?.toJson(),
  'kom_rank': instance.komRank,
  'pr_rank': instance.prRank,
  'achievements': ?instance.achievements,
  'hidden': instance.hidden,
};

Segment _$SegmentFromJson(Map<String, dynamic> json) => Segment(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
  name: json['name'] as String?,
  activityType: json['activity_type'] as String?,
  distance: (json['distance'] as num?)?.toDouble(),
  averageGrade: (json['average_grade'] as num?)?.toDouble(),
  maximumGrade: (json['maximum_grade'] as num?)?.toDouble(),
  elevationHigh: (json['elevation_high'] as num?)?.toDouble(),
  elevationLow: (json['elevation_low'] as num?)?.toDouble(),
  startLatlng: _latLngFromJson(json['start_latlng']),
  endLatlng: _latLngFromJson(json['end_latlng']),
  climbCategory: (json['climb_category'] as num?)?.toInt(),
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  private: json['private'] as bool?,
  hazardous: json['hazardous'] as bool?,
  starred: json['starred'] as bool?,
);

Map<String, dynamic> _$SegmentToJson(Segment instance) => <String, dynamic>{
  'id': instance.id,
  'resource_state': instance.resourceState,
  'name': instance.name,
  'activity_type': instance.activityType,
  'distance': instance.distance,
  'average_grade': instance.averageGrade,
  'maximum_grade': instance.maximumGrade,
  'elevation_high': instance.elevationHigh,
  'elevation_low': instance.elevationLow,
  'start_latlng': instance.startLatlng,
  'end_latlng': instance.endLatlng,
  'climb_category': instance.climbCategory,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'private': instance.private,
  'hazardous': instance.hazardous,
  'starred': instance.starred,
};

PolyLineMap _$PolyLineMapFromJson(Map<String, dynamic> json) => PolyLineMap(
  id: json['id'] as String?,
  polyline: json['polyline'] as String?,
  resourceState: (json['resource_state'] as num?)?.toInt(),
  summaryPolyline: json['summary_polyline'] as String?,
);

Map<String, dynamic> _$PolyLineMapToJson(PolyLineMap instance) =>
    <String, dynamic>{
      'id': instance.id,
      'polyline': instance.polyline,
      'resource_state': instance.resourceState,
      'summary_polyline': instance.summaryPolyline,
    };
