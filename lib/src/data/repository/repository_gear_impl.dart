import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model_gear.dart';
import 'package:strava_client/src/domain/repository/repository_gear.dart';

class RepositoryGearImpl extends RepositoryGear {
  @Deprecated('Gear ids are strings; use getGearById(String).')
  @override
  Future<Gear> getGear(int gearId) => getGearById(gearId.toString());

  @override
  Future<Gear> getGearById(String gearId) {
    return ApiClient.getRequest(
        endPoint: "/v3/gear/$gearId",
        dataConstructor: (data) =>
            Gear.fromJson(Map<String, dynamic>.from(data)));
  }
}
