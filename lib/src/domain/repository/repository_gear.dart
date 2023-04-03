import 'package:strava_client/src/domain/model/model_gear.dart';

abstract class RepositoryGear {
  /// Returns a [Gear] from its [gearId].
  ///
  /// {@macro fault_management}
  Future<Gear> getGear(int gearId);
}
