import 'package:strava_flutter/data/repository/client.dart';
import 'package:strava_flutter/domain/model/model_gear.dart';
import 'package:strava_flutter/domain/repository/repository_gear.dart';

class RepositoryGearImpl extends RepositoryGear{
  @override
  Future<Gear> getGear(int gearId) {
    return ApiClient.getRequest(endPoint: "/v3/gear/$gearId", dataConstructor: (data)=>Gear.fromJson(Map<String,dynamic>.from(data)));
  }

}