import 'package:get_it/get_it.dart';
import 'package:strava_client/src/common/session_manager.dart';
import 'package:strava_client/src/data/repository/repository.dart';
import 'package:strava_client/src/domain/repository/repository.dart';

GetIt sl = GetIt.instance;
bool didInitLocators = false;

void initServiceLocator() {
  if (didInitLocators) {
    return;
  }
  didInitLocators = true;
  if (!sl.isRegistered<SessionManager>()) {
    sl.registerSingleton<SessionManager>(SessionManager());
  }
  sl.registerFactory<RepositoryAthlete>(() => RepositoryAthleteImpl());
  sl.registerFactory<RepositoryAuthentication>(
    () => RepositoryAuthenticationImpl(),
  );
  sl.registerFactory<RepositoryActivity>(() => RepositoryActivityImpl());
  sl.registerFactory<RepositoryGear>(() => RepositoryGearImpl());
  sl.registerFactory<RepositoryRoute>(() => RepositoryRouteImpl());
  sl.registerFactory<RepositoryClub>(() => RepositoryClubImpl());
  sl.registerFactory<RepositoryRunningRace>(() => RepositoryRunningRaceImpl());
  sl.registerFactory<RepositorySegmentEffort>(
    () => RepositorySegmentEffortImpl(),
  );
  sl.registerFactory<RepositorySegment>(() => RepositorySegmentImpl());
  sl.registerFactory<RepositoryStream>(() => RepositoryStreamImpl());
  sl.registerFactory<RepositoryUpload>(() => RepositoryUploadImpl());
}
