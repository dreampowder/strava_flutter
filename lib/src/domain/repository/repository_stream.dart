import 'package:strava_client/src/domain/model/model_authentication_scopes.dart';
import 'package:strava_client/src/domain/model/model_stream_collection.dart';
import 'package:strava_client/src/domain/model/model_stream_set.dart';

/// Repository managing all API calls related to `streams`.
abstract class RepositoryStream {
  /// Returns from [activityId] its activity's streams as a list of
  /// [StravaStream]s (one per requested channel).
  ///
  /// Requires [AuthenticationScope.activity_read_all] for `Only Me` activities.
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StravaStream>> getActivityStreams(
    int activityId,
    List<String> keys,
  );

  /// Returns from [routeId] its route's streams as a list of [StravaStream]s.
  ///
  /// Requires [AuthenticationScope.read_all] for private routes.
  ///
  /// {@macro fault_management}
  Future<List<StravaStream>> getRouteStreams(int routeId);

  /// Returns from [segmentEffortId] its segment efforts's streams as a list of
  /// [StravaStream]s. (The segment effort must have been completed by the
  /// authenticated athlete).
  ///
  /// Requires [AuthenticationScope.read_all].
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StravaStream>> getSegmentEffortStreams(
    int segmentEffortId,
    List<String> keys,
  );

  /// Returns from [segmentId] its segment's streams as a list of
  /// [StravaStream]s.
  ///
  /// Requires [AuthenticationScope.read_all] for private segments.
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StravaStream>> getSegmentStreams(
    int segmentId,
    List<String> keys,
  );

  /// Returns from [activityId] its activity's streams as a [StreamCollection]
  /// (Strava's `key_by_type=true` form), keyed by stream type.
  ///
  /// Requires [AuthenticationScope.activity_read_all] for `Only Me` activities.
  ///
  /// {@macro fault_management}
  Future<StreamCollection> getActivityStreamsByType(
    int activityId,
    List<String> keys,
  );

  /// Returns from [routeId] its route's streams as a [StreamCollection].
  ///
  /// Requires [AuthenticationScope.read_all] for private routes.
  ///
  /// {@macro fault_management}
  Future<StreamCollection> getRouteStreamsByType(int routeId);

  /// Returns from [segmentEffortId] its segment effort's streams as a
  /// [StreamCollection].
  ///
  /// Requires [AuthenticationScope.read_all].
  ///
  /// {@macro fault_management}
  Future<StreamCollection> getSegmentEffortStreamsByType(
    int segmentEffortId,
    List<String> keys,
  );

  /// Returns from [segmentId] its segment's streams as a [StreamCollection].
  ///
  /// Requires [AuthenticationScope.read_all] for private segments.
  ///
  /// {@macro fault_management}
  Future<StreamCollection> getSegmentStreamsByType(
    int segmentId,
    List<String> keys,
  );
}
