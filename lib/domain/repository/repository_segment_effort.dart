import 'package:strava_client/domain/model/model_detailed_activity.dart';

abstract class RepositorySegmentEffort{
  Future<DetailedSegmentEffort> getSegmentEffort(int segmentId);
  Future<List<DetailedSegmentEffort>> listSegmentEfforts(int segmentId, DateTime startDate, DateTime endDate, int perPage);
}