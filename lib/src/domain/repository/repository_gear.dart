import 'package:strava_client/src/domain/model/model_gear.dart';

/// Repository managing all API calls related to `gear`.
abstract class RepositoryGear {
  /// Returns a [Gear] from its [gearId].
  ///
  /// {@macro fault_management}
  @Deprecated(
    'Gear ids are strings (e.g. "b1234567"), not ints. '
    'Use getGearById(String) instead. Removed in the next major version.',
  )
  Future<Gear> getGear(int gearId);

  /// Returns a [Gear] from its string [gearId] (e.g. `"b1234567"`).
  ///
  /// {@macro fault_management}
  Future<Gear> getGearById(String gearId);
}
