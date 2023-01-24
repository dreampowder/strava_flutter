import 'package:strava_client/domain/model/model_activity_type_enum.dart';
import 'package:strava_client/domain/model/model_detailed_segment.dart';
import 'package:strava_client/domain/model/model_latlng.dart';
import 'package:strava_client/domain/model/model_segment_leaderboard.dart';
import 'package:strava_client/domain/model/model_segment_leaderboard_request.dart';
import 'package:strava_client/domain/model/model_segments_explore.dart';
import 'package:strava_client/domain/model/model_summary_segment.dart';

abstract class RepositorySegment{
  Future<ExplorerResponse> exploreSegments(GeoPoint southWestCorner, GeoPoint northEastCorner, ActivityTypeEnum typeEnum,int minClimbingCategory, int maxClimbingCategory);
  Future<List<SummarySegment>> listStarredSegments(int page,int perPage);
  Future<DetailedSegment> getSegment(int segmentId);
  Future<DetailedSegment> starSegment(int segmentId,bool isStarred);
  Future<SegmentLeaderboard> getLeaderBoard(SegmentLeaderboardRequest request);
}