import 'package:strava_client/data/repository/client.dart';
import 'package:strava_client/domain/model/model_gear.dart';
import 'package:strava_client/domain/repository/repository_gear.dart';

class RepositoryGearImpl extends RepositoryGear{
  @override
  Future<Gear> getGear(int gearId) {
    return ApiClient.getRequest(endPoint: "/v3/gear/$gearId", dataConstructor: (data)=>Gear.fromJson(Map<String,dynamic>.from(data)));
  }

}