import 'package:dio/dio.dart';
import 'package:strava_client/data/repository/client.dart';
import 'package:strava_client/domain/model/model_activity_type_enum.dart';
import 'package:strava_client/domain/model/model_detailed_segment.dart';
import 'package:strava_client/domain/model/model_latlng.dart';
import 'package:strava_client/domain/model/model_segment_leaderboard.dart';
import 'package:strava_client/domain/model/model_segment_leaderboard_request.dart';
import 'package:strava_client/domain/model/model_segments_explore.dart';
import 'package:strava_client/domain/model/model_summary_segment.dart';
import 'package:strava_client/domain/repository/repository_segment.dart';

class RepositorySegmentImpl extends RepositorySegment{

  @override
  Future<ExplorerResponse> exploreSegments(GeoPoint southWestCorner, GeoPoint northEastCorner, ActivityTypeEnum typeEnum, int minClimbingCategory, int maxClimbingCategory) {
    var queryParams = {
      "bounds":[southWestCorner.lat, southWestCorner.lon, northEastCorner.lat,northEastCorner.lon],
      "activity_type":typeEnum.stringValue(),
      "min_cat":minClimbingCategory,
      "max_cat":maxClimbingCategory
    };
    return ApiClient.getRequest(endPoint: "/v3/segments/explore",queryParameters: queryParams, dataConstructor: (data)=>ExplorerResponse.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<List<SummarySegment>> listStarredSegments(int page, int perPage) {
    return ApiClient.getRequest(endPoint: "/v3/segments/starred",queryParameters: {"page":page, "per_page":perPage}, dataConstructor: (data){
      if(data is List){
        return data.map((e) => SummarySegment.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

  @override
  Future<DetailedSegment> getSegment(int segmentId) {
    return ApiClient.getRequest(endPoint: "/v3/segments/$segmentId", dataConstructor: (data)=>DetailedSegment.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<DetailedSegment> starSegment(int segmentId,bool isStarred) {
    FormData formData = FormData.fromMap({"starred":isStarred});
    return ApiClient.putRequest(endPoint: "/v3/segments/$segmentId/starred",postBody: formData, dataConstructor: (data)=>DetailedSegment.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<SegmentLeaderboard> getLeaderBoard(SegmentLeaderboardRequest request) {
    return ApiClient.getRequest(endPoint: "/v3/segments/${request.segmentId}/leaderboard",queryParameters: request.toJson(), dataConstructor: (data)=>SegmentLeaderboard.fromJson(Map<String,dynamic>.from(data)));
  }

}