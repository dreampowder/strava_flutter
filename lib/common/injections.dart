import 'package:get_it/get_it.dart';
import 'package:strava_client/common/session_manager.dart';
import 'package:strava_client/data/repository/repository_activity_impl.dart';
import 'package:strava_client/data/repository/repository_athlete_impl.dart';
import 'package:strava_client/data/repository/repository_authentication_impl.dart';
import 'package:strava_client/data/repository/repository_club_impl.dart';
import 'package:strava_client/data/repository/repository_gear_impl.dart';
import 'package:strava_client/data/repository/repository_route_impl.dart';
import 'package:strava_client/data/repository/repository_segment_efforts_impl.dart';
import 'package:strava_client/data/repository/repository_segment_impl.dart';
import 'package:strava_client/data/repository/repository_stream_impl.dart';
import 'package:strava_client/data/repository/repository_upload_impl.dart';
import 'package:strava_client/domain/repository/repository_activity.dart';
import 'package:strava_client/domain/repository/repository_athlete.dart';
import 'package:strava_client/domain/repository/repository_authentication.dart';
import 'package:strava_client/domain/repository/repository_club.dart';
import 'package:strava_client/domain/repository/repository_gear.dart';
import 'package:strava_client/domain/repository/repository_route.dart';
import 'package:strava_client/domain/repository/repository_running_race.dart';
import 'package:strava_client/domain/repository/repository_segment.dart';
import 'package:strava_client/domain/repository/repository_stream.dart';
import 'package:strava_client/domain/repository/repository_upload.dart';

import '../data/repository/repository_running_race_impl.dart';
import '../domain/repository/repository_segment_effort.dart';

GetIt sl  = GetIt.instance;
bool didInitLocators = false;

void initServiceLocator(){
  if (didInitLocators) {
    return;
  }
  didInitLocators = true;
  if (!sl.isRegistered<SessionManager>()) {
    sl.registerSingleton<SessionManager>(SessionManager());
  }
  sl.registerFactory<RepositoryAthlete>(() => RepositoryAthleteImpl());
  sl.registerFactory<RepositoryAuthentication>(() => RepositoryAuthenticationImpl());
  sl.registerFactory<RepositoryActivity>(() => RepositoryActivityImpl());
  sl.registerFactory<RepositoryGear>(() => RepositoryGearImpl());
  sl.registerFactory<RepositoryRoute>(() => RepositoryRouteImpl());
  sl.registerFactory<RepositoryClub>(() => RepositoryClubImpl());
  sl.registerFactory<RepositoryRunningRace>(() => RepositoryRunningRaceImpl());
  sl.registerFactory<RepositorySegmentEffort>(() => RepositorySegmentEffortImpl());
  sl.registerFactory<RepositorySegment>(() => RepositorySegmentImpl());
  sl.registerFactory<RepositoryStream>(() => RepositoryStreamImpl());
  sl.registerFactory<RepositoryUpload>(() => RepositoryUploadImpl());
}