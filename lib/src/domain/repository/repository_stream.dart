import 'package:strava_client/src/domain/model/model_authentication_scopes.dart';
import 'package:strava_client/src/domain/model/model_stream_set.dart';

/// Repository managing all API calls related to `streams`.
abstract class RepositoryStream {
  /// Returns from [activityId] its activity's streams as a [StreamSet].
  ///
  /// Requires [AuthenticationScope.activity_read_all] for `Only Me` activities.
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StreamSet>> getActivityStreams(int activityId, List<String> keys);

  /// Returns from [routeId] its route's streams as a [StreamSet].
  ///
  /// Requires [AuthenticationScope.read_all] for private routes.
  ///
  /// {@macro fault_management}
  Future<List<StreamSet>> getRouteStreams(int routeId);

  /// Returns from [segmentEffortId] its segment efforts's streams as a
  /// [StreamSet]. (The segment effort must have been completed by the
  /// authenticated athlete).
  ///
  /// Requires [AuthenticationScope.read_all].
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StreamSet>> getSegmentEffortStreams(
    int segmentEffortId,
    List<String> keys,
  );

  /// Returns from [segmentId] its segment's streams as a
  /// [StreamSet].
  ///
  /// Requires [AuthenticationScope.read_all] for private segments.
  ///
  /// [keys] specify the desired stream types.
  ///
  /// {@macro fault_management}
  Future<List<StreamSet>> getSegmentStreams(int segmentId, List<String> keys);
}
