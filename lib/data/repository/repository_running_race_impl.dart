import 'package:strava_client/data/repository/client.dart';
import 'package:strava_client/domain/model/model_running_race.dart';
import 'package:strava_client/domain/repository/repository_running_race.dart';

class RepositoryRunningRaceImpl extends RepositoryRunningRace{
  @override
  Future<RunningRace> getRage(int raceId) {
    return ApiClient.getRequest(endPoint: "/v3/running_races/$raceId", dataConstructor: (data)=>RunningRace.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<List<RunningRace>> listRunningRaces(int year) {
    return ApiClient.getRequest(endPoint: "/v3/running_races", dataConstructor: (data){
      if(data is List){
        return data.map((e) => RunningRace.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }
}