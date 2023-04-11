import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository_activity.dart';

import 'client.dart';

class RepositoryActivityImpl extends RepositoryActivity {
  @override
  Future<DetailedActivity> getActivity(int activityId) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId",
        dataConstructor: (data) =>
            DetailedActivity.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<List<Comment>> listActivityComments(int activityId) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/comments",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((d) => Comment.fromJson(Map<String, dynamic>.from(d)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<SummaryAthlete>> listActivityKudoers(int activityId) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/comments",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((d) =>
                    SummaryAthlete.fromJson(Map<String, dynamic>.from(d)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<Lap>> getLapsByActivityId(int activityId) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/laps",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((d) => Lap.fromJson(Map<String, dynamic>.from(d)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<SummaryActivity>> listLoggedInAthleteActivities(
      DateTime before, DateTime after, int page, int perPage) {
    var queryParams = {
      "before": before.millisecondsSinceEpoch / 1000,
      "after": after.millisecondsSinceEpoch / 1000,
      "page": page,
      "per_page": perPage
    };
    return ApiClient.getRequest(
        endPoint: "/v3/athlete/activities",
        queryParameters: queryParams,
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((d) =>
                    SummaryActivity.fromJson(Map<String, dynamic>.from(d)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<ActivityZone>> getActivityZones(int activityId) {
    return ApiClient.getRequest(
        endPoint: "/v3/activities/$activityId/zones",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((d) => ActivityZone.fromJson(Map<String, dynamic>.from(d)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<DetailedActivity> createActivity(CreateActivityRequest request) {
    return ApiClient.postRequest(
        endPoint: "/v3/activities",
        postBody: request.toJson(),
        dataConstructor: (data) =>
            DetailedActivity.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<DetailedActivity> updateActivity(
      int activityId, UpdateActivityRequest request) {
    return ApiClient.putRequest(
        endPoint: "/v3/activities/$activityId",
        dataConstructor: (data) =>
            DetailedActivity.fromJson(Map<String, dynamic>.from(data)));
  }
}
