import 'package:strava_flutter/domain/model/model_activity_request_create.dart';
import 'package:strava_flutter/domain/model/model_activity_request_update.dart';
import 'package:strava_flutter/domain/model/model_activity_zone.dart';
import 'package:strava_flutter/domain/model/model_comment.dart';
import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/model/model_lap.dart';
import 'package:strava_flutter/domain/model/model_summary_activity.dart';
import 'package:strava_flutter/domain/model/model_summary_athlete.dart';

abstract class RepositoryActivity{

  Future<DetailedActivity> getActivity(int activityId);
  Future<List<Comment>> listActivityComments(int activityId);
  Future<List<SummaryAthlete>> listActivityKudoers(int activityId);
  Future<List<Lap>> getLapsByActivityId(int activityId);
  Future<List<SummaryActivity>> listLoggedInAthleteActivities(DateTime before, DateTime after, int page, int perPage);
  Future<List<ActivityZone>> getActivityZones(int activityId);
  Future<DetailedActivity> createActivity(CreateActivityRequest request);
  Future<DetailedActivity> updateActivity(int activityId, UpdateActivityRequest request);
}