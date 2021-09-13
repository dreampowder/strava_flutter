import 'package:strava_flutter/common/local_storage.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/repository/repository_activity.dart';
import 'package:strava_flutter/domain/repository/repository_athlete.dart';
import 'package:strava_flutter/domain/repository/repository_authentication.dart';
import 'package:strava_flutter/domain/repository/repository_club.dart';
import 'package:strava_flutter/domain/repository/repository_gear.dart';
import 'package:strava_flutter/domain/repository/repository_route.dart';
import 'package:strava_flutter/domain/repository/repository_running_race.dart';
import 'package:strava_flutter/domain/repository/repository_segment.dart';
import 'package:strava_flutter/domain/repository/repository_stream.dart';
import 'package:strava_flutter/domain/repository/repository_upload.dart';
import 'package:strava_flutter/domain/repository/resository_segment_effort.dart';
import 'package:strava_flutter/common/injections.dart';

class StravaClient{
  final String secret;
  final String clientId;

  RepositoryAthlete get athletes => sl();
  RepositoryAuthentication get authentication => sl();
  RepositoryActivity get activities => sl();
  RepositoryGear get gears => sl();
  RepositoryRoute get routes => sl();
  RepositoryClub get clubs => sl();
  RepositoryRunningRace get runningRaces => sl();
  RepositorySegmentEffort get segmentEfforts => sl();
  RepositorySegment get segments => sl();
  RepositoryStream get streams => sl();
  RepositoryUpload get uploads => sl();

  StravaClient({required this.secret,required this.clientId, String applicationName = ""}){
    initServiceLocator();
    sl<SessionManager>().initialize(secret: secret, clientId: clientId,applicationName: applicationName);
  }

  ///Returns stored strava token if needed.
  ///returns null if there is no logged in user
  Future<TokenResponse?> getStravaAuthToken(){
    return LocalStorageManager.getToken();
  }
}
