import 'package:strava_client/strava_client.dart';

import 'api_models.dart';

const _page = ApiParam(
    key: "page", label: "Page", type: ParamType.int, defaultValue: 1);
const _perPage = ApiParam(
    key: "perPage", label: "Per page", type: ParamType.int, defaultValue: 30);

ApiParam _id(String key, String label) =>
    ApiParam(key: key, label: label, type: ParamType.int);

final ApiParam _activityTypeParam = ApiParam(
  key: "type",
  label: "Activity type",
  type: ParamType.enumValue,
  defaultValue: ActivityTypeEnum.Ride,
  enumValues: ActivityTypeEnum.values,
  enumLabel: (v) => (v as ActivityTypeEnum).name,
);

/// Every Strava API call the example app can run, grouped by repository.
final List<ApiCall> kApiCalls = [
  // ---------------------------------------------------------------- Athlete
  ApiCall(
    group: "Athlete",
    name: "getAuthenticatedAthlete",
    description: "The currently authenticated athlete.",
    run: (c, a) => c.athletes.getAuthenticatedAthlete(),
  ),
  ApiCall(
    group: "Athlete",
    name: "getAthleteZones",
    description: "Heart-rate and power zones (correct /athlete/zones model).",
    run: (c, a) => c.athletes.getAthleteZones(),
  ),
  ApiCall(
    group: "Athlete",
    name: "getAthleteStats",
    description: "Activity totals/stats for an athlete id.",
    params: [_id("athleteId", "Athlete id")],
    run: (c, a) => c.athletes.getAthleteStats(a["athleteId"] as int),
  ),

  // --------------------------------------------------------------- Activity
  ApiCall(
    group: "Activity",
    name: "getActivity",
    description: "A detailed activity by id.",
    params: [_id("activityId", "Activity id")],
    run: (c, a) => c.activities.getActivity(a["activityId"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "listLoggedInAthleteActivities",
    description: "Your activities within a date window.",
    params: [
      ApiParam(
          key: "before",
          label: "Before (ISO date)",
          type: ParamType.dateTime,
          defaultValue: DateTime.now()),
      ApiParam(
          key: "after",
          label: "After (ISO date)",
          type: ParamType.dateTime,
          defaultValue: DateTime.now().subtract(const Duration(days: 30))),
      _page,
      _perPage,
    ],
    run: (c, a) => c.activities.listLoggedInAthleteActivities(
        a["before"] as DateTime,
        a["after"] as DateTime,
        a["page"] as int,
        a["perPage"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "listActivityComments",
    description: "Comments on an activity.",
    params: [_id("activityId", "Activity id")],
    run: (c, a) => c.activities.listActivityComments(a["activityId"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "listActivityKudoers",
    description: "Athletes who kudoed an activity.",
    params: [_id("activityId", "Activity id")],
    run: (c, a) => c.activities.listActivityKudoers(a["activityId"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "getLapsByActivityId",
    description: "Laps of an activity.",
    params: [_id("activityId", "Activity id")],
    run: (c, a) => c.activities.getLapsByActivityId(a["activityId"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "getActivityZones",
    description: "Zones for an activity.",
    params: [_id("activityId", "Activity id")],
    run: (c, a) => c.activities.getActivityZones(a["activityId"] as int),
  ),
  ApiCall(
    group: "Activity",
    name: "createActivity",
    description: "Create a manual activity.",
    isWrite: true,
    params: [
      ApiParam(key: "name", label: "Name", type: ParamType.string),
      _activityTypeParam,
      ApiParam(
          key: "startDateLocal",
          label: "Start date local (ISO)",
          type: ParamType.dateTime,
          defaultValue: DateTime.now()),
      ApiParam(
          key: "elapsedTime",
          label: "Elapsed time (s)",
          type: ParamType.int,
          defaultValue: 3600),
      ApiParam(
          key: "description",
          label: "Description",
          type: ParamType.string,
          defaultValue: ""),
      ApiParam(
          key: "distance",
          label: "Distance (m)",
          type: ParamType.double,
          defaultValue: 0.0),
      ApiParam(
          key: "trainer",
          label: "Trainer",
          type: ParamType.bool,
          defaultValue: false),
      ApiParam(
          key: "commute",
          label: "Commute",
          type: ParamType.bool,
          defaultValue: false),
    ],
    run: (c, a) => c.activities.createActivity(CreateActivityRequest(
        a["name"] as String,
        a["type"] as ActivityTypeEnum,
        a["startDateLocal"] as DateTime,
        a["elapsedTime"] as int,
        a["description"] as String,
        a["distance"] as double,
        a["trainer"] as bool,
        a["commute"] as bool)),
  ),
  ApiCall(
    group: "Activity",
    name: "updateActivity",
    description: "Update an existing activity.",
    isWrite: true,
    params: [
      _id("activityId", "Activity id"),
      ApiParam(key: "name", label: "Name (blank = skip)", type: ParamType.string),
      ApiParam(
          key: "description",
          label: "Description (blank = skip)",
          type: ParamType.string),
      ApiParam(
          key: "gearId", label: "Gear id (blank = skip)", type: ParamType.string),
    ],
    run: (c, a) => c.activities.updateActivity(
          a["activityId"] as int,
          UpdateActivityRequest(
            name: (a["name"] as String?)?.isEmpty ?? true
                ? null
                : a["name"] as String,
            description: (a["description"] as String?)?.isEmpty ?? true
                ? null
                : a["description"] as String,
            gearId: (a["gearId"] as String?)?.isEmpty ?? true
                ? null
                : a["gearId"] as String,
          ),
        ),
  ),

  // ------------------------------------------------------------------- Club
  ApiCall(
    group: "Club",
    name: "getClub",
    description: "A club by id.",
    params: [_id("clubId", "Club id")],
    run: (c, a) => c.clubs.getClub(a["clubId"] as int),
  ),
  ApiCall(
    group: "Club",
    name: "getLoggedInAthleteClubs",
    description: "Clubs you belong to.",
    params: [_page, _perPage],
    run: (c, a) =>
        c.clubs.getLoggedInAthleteClubs(a["page"] as int, a["perPage"] as int),
  ),
  ApiCall(
    group: "Club",
    name: "listClubActivities",
    description: "Recent activities of a club.",
    params: [_id("clubId", "Club id"), _page, _perPage],
    run: (c, a) => c.clubs.listClubActivities(
        a["clubId"] as int, a["page"] as int, a["perPage"] as int),
  ),
  ApiCall(
    group: "Club",
    name: "listClubAdministrators",
    description: "Administrators of a club.",
    params: [_id("clubId", "Club id"), _page, _perPage],
    run: (c, a) => c.clubs.listClubAdministrators(
        a["clubId"] as int, a["page"] as int, a["perPage"] as int),
  ),
  ApiCall(
    group: "Club",
    name: "listClubMembers",
    description: "Members of a club.",
    params: [_id("clubId", "Club id"), _page, _perPage],
    run: (c, a) => c.clubs.listClubMembers(
        a["clubId"] as int, a["page"] as int, a["perPage"] as int),
  ),

  // ------------------------------------------------------------------- Gear
  ApiCall(
    group: "Gear",
    name: "getGear",
    description: "Gear (bike/shoe) by id.",
    params: [_id("gearId", "Gear id")],
    run: (c, a) => c.gears.getGear(a["gearId"] as int),
  ),

  // ------------------------------------------------------------------ Route
  ApiCall(
    group: "Route",
    name: "getRoute",
    description: "A route by id.",
    params: [_id("routeId", "Route id")],
    run: (c, a) => c.routes.getRoute(a["routeId"] as int),
  ),
  ApiCall(
    group: "Route",
    name: "listAthleteRoutes",
    description: "Routes created by an athlete.",
    params: [_id("athleteId", "Athlete id"), _page, _perPage],
    run: (c, a) => c.routes.listAthleteRoutes(
        a["athleteId"] as int, a["page"] as int, a["perPage"] as int),
  ),
  ApiCall(
    group: "Route",
    name: "exportRouteGPX",
    description: "Export a route as GPX (binary).",
    params: [_id("routeId", "Route id")],
    run: (c, a) => c.routes.exportRouteGPX(a["routeId"] as int),
  ),
  ApiCall(
    group: "Route",
    name: "exportRouteTCX",
    description: "Export a route as TCX (binary).",
    params: [_id("routeId", "Route id")],
    run: (c, a) => c.routes.exportRouteTCX(a["routeId"] as int),
  ),

  // ----------------------------------------------------------- RunningRaces
  ApiCall(
    group: "Running races",
    name: "getRage",
    description: "A running race by id.",
    params: [_id("raceId", "Race id")],
    run: (c, a) => c.runningRaces.getRage(a["raceId"] as int),
  ),
  ApiCall(
    group: "Running races",
    name: "listRunningRaces",
    description: "Running races in a given year.",
    params: [
      ApiParam(
          key: "year",
          label: "Year",
          type: ParamType.int,
          defaultValue: DateTime.now().year)
    ],
    run: (c, a) => c.runningRaces.listRunningRaces(a["year"] as int),
  ),

  // --------------------------------------------------------- Segment effort
  ApiCall(
    group: "Segment efforts",
    name: "getSegmentEffort",
    description: "A segment effort by id.",
    params: [_id("effortId", "Segment effort id")],
    run: (c, a) => c.segmentEfforts.getSegmentEffort(a["effortId"] as int),
  ),
  ApiCall(
    group: "Segment efforts",
    name: "listSegmentEfforts",
    description: "Your efforts on a segment within a date window.",
    params: [
      _id("segmentId", "Segment id"),
      ApiParam(
          key: "startDate",
          label: "Start date (ISO)",
          type: ParamType.dateTime,
          defaultValue: DateTime.now().subtract(const Duration(days: 365))),
      ApiParam(
          key: "endDate",
          label: "End date (ISO)",
          type: ParamType.dateTime,
          defaultValue: DateTime.now()),
      _perPage,
    ],
    run: (c, a) => c.segmentEfforts.listSegmentEfforts(
        a["segmentId"] as int,
        a["startDate"] as DateTime,
        a["endDate"] as DateTime,
        a["perPage"] as int),
  ),

  // ---------------------------------------------------------------- Segment
  ApiCall(
    group: "Segment",
    name: "getSegment",
    description: "A detailed segment by id.",
    params: [_id("segmentId", "Segment id")],
    run: (c, a) => c.segments.getSegment(a["segmentId"] as int),
  ),
  ApiCall(
    group: "Segment",
    name: "listStarredSegments",
    description: "Your starred segments.",
    params: [_page, _perPage],
    run: (c, a) =>
        c.segments.listStarredSegments(a["page"] as int, a["perPage"] as int),
  ),
  ApiCall(
    group: "Segment",
    name: "starSegment",
    description: "Star or unstar a segment.",
    isWrite: true,
    params: [
      _id("segmentId", "Segment id"),
      ApiParam(
          key: "starred",
          label: "Starred",
          type: ParamType.bool,
          defaultValue: true),
    ],
    run: (c, a) =>
        c.segments.starSegment(a["segmentId"] as int, a["starred"] as bool),
  ),
  ApiCall(
    group: "Segment",
    name: "exploreSegments",
    description: "Explore segments within a bounding box.",
    params: [
      ApiParam(
          key: "swLat",
          label: "SW latitude",
          type: ParamType.double,
          defaultValue: 37.821),
      ApiParam(
          key: "swLon",
          label: "SW longitude",
          type: ParamType.double,
          defaultValue: -122.505),
      ApiParam(
          key: "neLat",
          label: "NE latitude",
          type: ParamType.double,
          defaultValue: 37.842),
      ApiParam(
          key: "neLon",
          label: "NE longitude",
          type: ParamType.double,
          defaultValue: -122.465),
      _activityTypeParam,
      ApiParam(
          key: "minCat",
          label: "Min climb category",
          type: ParamType.int,
          defaultValue: 0),
      ApiParam(
          key: "maxCat",
          label: "Max climb category",
          type: ParamType.int,
          defaultValue: 5),
    ],
    run: (c, a) => c.segments.exploreSegments(
        GeoPoint(a["swLat"] as double, a["swLon"] as double),
        GeoPoint(a["neLat"] as double, a["neLon"] as double),
        a["type"] as ActivityTypeEnum,
        a["minCat"] as int,
        a["maxCat"] as int),
  ),
  ApiCall(
    group: "Segment",
    name: "getLeaderBoard",
    description: "Segment leaderboard.",
    params: [
      _id("segmentId", "Segment id"),
      ApiParam(
          key: "gender",
          label: "Gender",
          type: ParamType.enumValue,
          defaultValue: SegmentGender.male,
          enumValues: SegmentGender.values,
          enumLabel: (v) => (v as SegmentGender).name),
      ApiParam(
          key: "ageGroup",
          label: "Age group",
          type: ParamType.enumValue,
          defaultValue: SegmentAgeGroup.values.first,
          enumValues: SegmentAgeGroup.values,
          enumLabel: (v) => (v as SegmentAgeGroup).name),
      ApiParam(
          key: "weightClass",
          label: "Weight class",
          type: ParamType.enumValue,
          defaultValue: SegmentWeightClass.values.first,
          enumValues: SegmentWeightClass.values,
          enumLabel: (v) => (v as SegmentWeightClass).name),
      ApiParam(
          key: "dateRange",
          label: "Date range",
          type: ParamType.enumValue,
          defaultValue: SegmentDateRange.this_year,
          enumValues: SegmentDateRange.values,
          enumLabel: (v) => (v as SegmentDateRange).name),
      ApiParam(
          key: "clubId", label: "Club id (0 = none)", type: ParamType.int,
          defaultValue: 0),
      ApiParam(
          key: "maxEntries",
          label: "Max entries",
          type: ParamType.int,
          defaultValue: 10),
      ApiParam(
          key: "following",
          label: "Following only",
          type: ParamType.bool,
          defaultValue: false),
      _page,
      _perPage,
    ],
    run: (c, a) => c.segments.getLeaderBoard(SegmentLeaderboardRequest(
        a["dateRange"] as SegmentDateRange,
        a["gender"] as SegmentGender,
        a["ageGroup"] as SegmentAgeGroup,
        a["weightClass"] as SegmentWeightClass,
        a["segmentId"] as int,
        a["clubId"] as int,
        a["maxEntries"] as int,
        a["following"] as bool,
        a["page"] as int,
        a["perPage"] as int)),
  ),

  // ----------------------------------------------------------------- Stream
  ApiCall(
    group: "Stream",
    name: "getActivityStreams",
    description: "Activity streams as a list (array form).",
    params: [_id("activityId", "Activity id"), _streamKeys],
    run: (c, a) => c.streams
        .getActivityStreams(a["activityId"] as int, a["keys"] as List<String>),
  ),
  ApiCall(
    group: "Stream",
    name: "getActivityStreamsByType",
    description: "Activity streams keyed by type (StreamCollection).",
    params: [_id("activityId", "Activity id"), _streamKeys],
    run: (c, a) => c.streams.getActivityStreamsByType(
        a["activityId"] as int, a["keys"] as List<String>),
  ),
  ApiCall(
    group: "Stream",
    name: "getRouteStreams",
    description: "Route streams as a list.",
    params: [_id("routeId", "Route id")],
    run: (c, a) => c.streams.getRouteStreams(a["routeId"] as int),
  ),
  ApiCall(
    group: "Stream",
    name: "getRouteStreamsByType",
    description: "Route streams keyed by type.",
    params: [_id("routeId", "Route id")],
    run: (c, a) => c.streams.getRouteStreamsByType(a["routeId"] as int),
  ),
  ApiCall(
    group: "Stream",
    name: "getSegmentEffortStreams",
    description: "Segment-effort streams as a list.",
    params: [_id("effortId", "Segment effort id"), _streamKeys],
    run: (c, a) => c.streams.getSegmentEffortStreams(
        a["effortId"] as int, a["keys"] as List<String>),
  ),
  ApiCall(
    group: "Stream",
    name: "getSegmentEffortStreamsByType",
    description: "Segment-effort streams keyed by type.",
    params: [_id("effortId", "Segment effort id"), _streamKeys],
    run: (c, a) => c.streams.getSegmentEffortStreamsByType(
        a["effortId"] as int, a["keys"] as List<String>),
  ),
  ApiCall(
    group: "Stream",
    name: "getSegmentStreams",
    description: "Segment streams as a list.",
    params: [_id("segmentId", "Segment id"), _streamKeys],
    run: (c, a) => c.streams
        .getSegmentStreams(a["segmentId"] as int, a["keys"] as List<String>),
  ),
  ApiCall(
    group: "Stream",
    name: "getSegmentStreamsByType",
    description: "Segment streams keyed by type.",
    params: [_id("segmentId", "Segment id"), _streamKeys],
    run: (c, a) => c.streams.getSegmentStreamsByType(
        a["segmentId"] as int, a["keys"] as List<String>),
  ),

  // ----------------------------------------------------------------- Upload
  ApiCall(
    group: "Upload",
    name: "getUpload",
    description: "Status of an upload by id.",
    params: [_id("uploadId", "Upload id")],
    run: (c, a) => c.uploads.getUpload(a["uploadId"] as int),
  ),
];

const _streamKeys = ApiParam(
  key: "keys",
  label: "Keys (comma separated)",
  type: ParamType.stringList,
  defaultValue: "distance,heartrate,watts",
  hint: "time, distance, latlng, altitude, velocity_smooth, heartrate, "
      "cadence, watts, temp, moving, grade_smooth",
);

/// Calls grouped by [ApiCall.group], preserving registry order.
Map<String, List<ApiCall>> groupedApiCalls() {
  final map = <String, List<ApiCall>>{};
  for (final call in kApiCalls) {
    map.putIfAbsent(call.group, () => []).add(call);
  }
  return map;
}
