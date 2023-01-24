import 'package:strava_client/data/repository/client.dart';
import 'package:strava_client/domain/model/model_stream_set.dart';
import 'package:strava_client/domain/repository/repository_stream.dart';

class RepositoryStreamImpl extends RepositoryStream{
  @override
  Future<List<StreamSet>> getActivityStreams(int activityId, List<String> keys) {
    return ApiClient.getRequest(endPoint: "/v3/activities/$activityId/streams",queryParameters: {"keys":keys, "key_by_type":true}, dataConstructor: (data){
      if(data is List){
        return data.map((e) => StreamSet.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<StreamSet>> getRouteStreams(int routeId) {
    return ApiClient.getRequest(endPoint: "/v3/routes/$routeId/streams", dataConstructor: (data){
      if(data is List){
        return data.map((e) => StreamSet.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<StreamSet>> getSegmentEffortStreams(int segmentEffortId, List<String> keys) {
    return ApiClient.getRequest(endPoint: "/v3/segment_efforts/$segmentEffortId/streams",queryParameters: {"keys":keys, "key_by_type":true}, dataConstructor: (data){
      if(data is List){
        return data.map((e) => StreamSet.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

  @override
  Future<List<StreamSet>> getSegmentStreams(int segmentId, List<String> keys) {
    return ApiClient.getRequest(endPoint: "/v3/segments/$segmentId/streams",queryParameters: {"keys":keys, "key_by_type":true}, dataConstructor: (data){
      if(data is List){
        return data.map((e) => StreamSet.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

}