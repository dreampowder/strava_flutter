import 'package:get_it/get_it.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/data/repository/repository_athlete_impl.dart';
import 'package:strava_flutter/data/repository/repository_authentication_impl.dart';
import 'package:strava_flutter/domain/repository/repository_athlete.dart';
import 'package:strava_flutter/domain/repository/repository_authentication.dart';

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
}