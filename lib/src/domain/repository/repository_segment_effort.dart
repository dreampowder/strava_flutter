import 'package:strava_client/src/domain/model/model_detailed_activity.dart';

/// Repository managing all API calls related to `segments effort`.
abstract class RepositorySegmentEffort {
  /// Returns a list of the authenticated `athlete`'s [DetailedSegmentEffort]s
  /// for the segment with this [segmentId]. (*Requires Subscription*)
  ///
  /// [startDate] and [endDate] are [DateTime]s allowing to filter the efforts.
  ///
  /// {@macro fault_management}
  Future<List<DetailedSegmentEffort>> listSegmentEfforts(
    int segmentId,
    DateTime startDate,
    DateTime endDate,
    int perPage,
  );

  /// Returns a [DetailedSegmentEffort] from a [segmentId]. (*Requires
  /// Subscription*)
  ///
  /// {@macro fault_management}
  Future<DetailedSegmentEffort> getSegmentEffort(int segmentId);
}
