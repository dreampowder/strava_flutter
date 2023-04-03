import 'package:strava_client/src/domain/model/model.dart';

abstract class RepositoryAthlete {
  /// Returns the currently authenticated `athlete`.
  ///
  /// Tokens with [AuthenticationScope.profile_read_all] will receive a
  /// [DetailedAthlete] representation; all others will receive a
  /// [SummaryAthlete].
  ///
  /// {@macro fault_management}
  Future<DetailedAthlete> getAuthenticatedAthlete();

  /// Returns the authenticated `athlete` its [Zones].
  ///
  /// Requires [AuthenticationScope.profile_read_all].
  ///
  /// {@macro fault_management}
  Future<List<Zones>> getZones();

  /// Returns the [ActivityStats] of the `athlete` with this [athleteId].
  ///
  /// Only includes data from activities set to `Everyone` visibility.
  ///
  /// {@macro fault_management}
  Future<ActivityStats> getAthleteStats(int athleteId);

  /// Updates the currently authenticated `athlete` with a new [weight] in
  /// kilogram and returns the updated [DetailedAthlete].
  ///
  /// Requires [AuthenticationScope.profile_write].
  ///
  /// {@macro fault_management}
  Future<DetailedAthlete> updateAthlete(double weight);
}
