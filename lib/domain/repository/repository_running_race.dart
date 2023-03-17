import 'package:strava_client/domain/model/model_running_race.dart';

abstract class RepositoryRunningRace {
  Future<RunningRace> getRage(int raceId);
  Future<List<RunningRace>> listRunningRaces(int year);
}
