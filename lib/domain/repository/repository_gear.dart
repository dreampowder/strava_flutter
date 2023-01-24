import 'package:strava_client/domain/model/model_gear.dart';

abstract class RepositoryGear{
  Future<Gear> getGear(int gearId);
}