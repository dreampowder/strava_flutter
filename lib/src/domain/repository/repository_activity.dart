import 'package:strava_client/src/domain/model/model.dart';

abstract class RepositoryActivity {
  /// Returns the [DetailedActivity] corresponding to the given [activityId].
  ///
  /// {@template required_read_scopes}
  /// Requires [AuthenticationScope.activity_read] for `Everyone` and
  /// `Followers` activities. Requires [AuthenticationScope.activity_read_all]
  /// for `Only Me` activities.
  /// {@endtemplate}
  ///
  /// {@template fault_management}
  /// If the operation fails, returns a [Fault] or a simple `error` and
  /// `stacktrace` if the fault cannot be identified.
  /// {@endtemplate}
  Future<DetailedActivity> getActivity(int activityId);

  /// Returns the [Comment]s of the `activity` with this [activityId].
  ///
  /// {@macro required_read_scopes}
  ///
  /// {@macro fault_management}
  Future<List<Comment>> listActivityComments(int activityId);

  /// Returns the [SummaryAthlete]s who *kodoed* the `activity` with this
  /// [activityId].
  ///
  /// {@macro required_read_scopes}
  ///
  /// {@macro fault_management}
  Future<List<SummaryAthlete>> listActivityKudoers(int activityId);

  /// Returns the [Lap]s of the `activity` with this [activityId].
  ///
  /// {@macro required_read_scopes}
  ///
  /// {@macro fault_management}
  Future<List<Lap>> getLapsByActivityId(int activityId);

  /// Returns a list of [SummaryActivity]s of the logged in athlete.
  ///
  /// [before] and [after] are two [DateTime]s used to filter out the
  /// `activities`.
  ///
  /// {@macro required_read_scopes}
  ///
  /// {@macro fault_management}
  Future<List<SummaryActivity>> listLoggedInAthleteActivities(
    DateTime before,
    DateTime after,
    int page,
    int perPage,
  );

  /// Returns the [ActivityZone]s of the `activity` with this [activityId].
  /// (*Summit Feature*)
  ///
  /// {@macro required_read_scopes}
  ///
  /// {@macro fault_management}
  Future<List<ActivityZone>> getActivityZones(int activityId);

  /// Creates a manual `activity` from a [CreateActivityRequest] and returns the
  /// created [DetailedActivity].
  ///
  /// Requires [AuthenticationScope.activity_write].
  ///
  /// {@macro fault_management}
  Future<DetailedActivity> createActivity(CreateActivityRequest request);

  /// Updates the `activity` corresponding to this [activityId] with an
  /// [UpdateActivityRequest] and returns the updated [DetailedActivity].
  ///
  /// Requires [AuthenticationScope.activity_write]. Also requires
  /// [AuthenticationScope.activity_read_all] in order to update `Only Me`
  /// activities.
  ///
  /// {@macro fault_management}
  Future<DetailedActivity> updateActivity(
    int activityId,
    UpdateActivityRequest request,
  );
}
