import 'package:strava_flutter/domain/model/model_gear.dart';

abstract class RepositoryGear{
  Future<Gear> getGear(int gearId);
}