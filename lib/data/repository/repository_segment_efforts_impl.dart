import 'package:strava_flutter/data/repository/client.dart';
import 'package:strava_flutter/domain/model/model_detailed_activity.dart';
import 'package:strava_flutter/domain/repository/repository_segment_effort.dart';

class RepositorySegmentEffortImpl extends RepositorySegmentEffort{

  @override
  Future<DetailedSegmentEffort> getSegmentEffort(int segmentId) {
    return ApiClient.getRequest(endPoint: "/v3/segment_efforts/$segmentId", dataConstructor: (data)=>DetailedSegmentEffort.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<List<DetailedSegmentEffort>> listSegmentEfforts(int segmentId, DateTime startDate, DateTime endDate, int perPage) {
    var queryParams = {
      "segment_id":segmentId,
      "start_date_local":startDate.toIso8601String(),
      "end_date_local":endDate.toIso8601String(),
      "per_page":perPage
    };
    return ApiClient.getRequest(endPoint: "/v3/segment_efforts",queryParameters: queryParams, dataConstructor: (data){
      if(data is List){
        return data.map((e) => DetailedSegmentEffort.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }
}