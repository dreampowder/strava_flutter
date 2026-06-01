import 'package:strava_client/src/domain/model/model.dart';

/// Repository managing all API calls related to `athletes`.
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
  @Deprecated('Mismodels GET /athlete/zones (which returns a single '
      '{heart_rate, power} object, not a list). Use getAthleteZones() instead. '
      'Removed in the next major version.')
  Future<List<Zones>> getZones();

  /// Returns the authenticated `athlete`'s heart-rate and power zones as an
  /// [AthleteZones] object (the correct model for `GET /athlete/zones`).
  ///
  /// Requires [AuthenticationScope.profile_read_all].
  ///
  /// {@macro fault_management}
  Future<AthleteZones> getAthleteZones();

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
