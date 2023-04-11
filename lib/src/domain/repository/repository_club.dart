import 'package:strava_client/src/domain/model/model.dart';

/// Repository managing all API calls related to `clubs`.
abstract class RepositoryClub {
  /// Returns the recent [SummaryActivity]s from `members` of the `club` with
  /// this [clubId].
  ///
  /// The authenticated `athlete` must belong to the requested `club` in order
  /// to hit this endpoint. Pagination is supported. Athlete profile visibility
  /// is respected for all activities.
  ///
  /// {@macro fault_management}
  Future<List<SummaryActivity>> listClubActivities(
    int clubId,
    int page,
    int perPage,
  );

  /// Returns a list of the `administrators` of the `club` with this [clubId].
  ///
  /// {@macro fault_management}
  Future<List<SummaryAthlete>> listClubAdministrators(
    int clubId,
    int page,
    int perPage,
  );

  /// Returns the [Club] with the id [clubId].
  ///
  /// {@macro fault_management}
  Future<Club> getClub(int clubId);

  /// Returns a list of [SummaryAthlete]s who are members of the club with this
  /// [clubId].
  ///
  /// [page] defines the page number and [perPage], the number of items per page
  /// (defaulting to 30).
  ///
  /// {@macro fault_management}
  Future<List<SummaryAthlete>> listClubMembers(
    int clubId,
    int page,
    int perPage,
  );

  /// Returns a list of the [SummaryClub]s whose membership includes the
  /// authenticated athlete.
  ///
  /// {@macro fault_management}
  Future<List<SummaryClub>> getLoggedInAthleteClubs(int page, int perPage);
}
