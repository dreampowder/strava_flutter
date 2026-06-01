import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model_stream_collection.dart';
import 'package:strava_client/src/domain/model/model_stream_set.dart';
import 'package:strava_client/src/domain/repository/repository_stream.dart';

class RepositoryStreamImpl extends RepositoryStream {
  List<StravaStream> _parseList(dynamic data) {
    if (data is List) {
      return data
          .map((e) => StravaStream.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  StreamCollection _parseCollection(dynamic data) {
    if (data is Map) {
      return StreamCollection.fromJson(Map<String, dynamic>.from(data));
    }
    return StreamCollection();
  }

  @override
  Future<List<StravaStream>> getActivityStreams(
      int activityId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/streams",
        queryParameters: {"keys": keys, "key_by_type": false},
        dataConstructor: _parseList);
  }

  @override
  Future<List<StravaStream>> getRouteStreams(int routeId) {
    return ApiClient.getRequest(
        endPoint: "/v3/routes/$routeId/streams",
        dataConstructor: _parseList);
  }

  @override
  Future<List<StravaStream>> getSegmentEffortStreams(
      int segmentEffortId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/segment_efforts/$segmentEffortId/streams",
        queryParameters: {"keys": keys, "key_by_type": false},
        dataConstructor: _parseList);
  }

  @override
  Future<List<StravaStream>> getSegmentStreams(
      int segmentId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/$segmentId/streams",
        queryParameters: {"keys": keys, "key_by_type": false},
        dataConstructor: _parseList);
  }

  @override
  Future<StreamCollection> getActivityStreamsByType(
      int activityId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/streams",
        queryParameters: {"keys": keys, "key_by_type": true},
        dataConstructor: _parseCollection);
  }

  @override
  Future<StreamCollection> getRouteStreamsByType(int routeId) {
    return ApiClient.getRequest(
        endPoint: "/v3/routes/$routeId/streams",
        queryParameters: {"key_by_type": true},
        dataConstructor: _parseCollection);
  }

  @override
  Future<StreamCollection> getSegmentEffortStreamsByType(
      int segmentEffortId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/segment_efforts/$segmentEffortId/streams",
        queryParameters: {"keys": keys, "key_by_type": true},
        dataConstructor: _parseCollection);
  }

  @override
  Future<StreamCollection> getSegmentStreamsByType(
      int segmentId, List<String> keys) {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/$segmentId/streams",
        queryParameters: {"keys": keys, "key_by_type": true},
        dataConstructor: _parseCollection);
  }
}
