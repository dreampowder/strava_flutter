import 'package:strava_flutter/domain/model/model_stream_set.dart';

abstract class RepositoryStream{
  Future<List<StreamSet>> getActivityStreams(int activityId, List<String> keys);
  Future<List<StreamSet>> getRouteStreams(int routeId);
  Future<List<StreamSet>> getSegmentEffortStreams(int segmentEffortId, List<String> keys);
  Future<List<StreamSet>> getSegmentStreams(int segmentId, List<String> keys);
}