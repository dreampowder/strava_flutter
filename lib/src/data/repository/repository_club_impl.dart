import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository_club.dart';

class RepositoryClubImpl extends RepositoryClub {
  @override
  Future<Club> getClub(int clubId) {
    return ApiClient.getRequest(
        endPoint: "/v3/clubs/$clubId",
        dataConstructor: (data) =>
            Club.fromJson(Map<String, dynamic>.from(data)));
  }

  @override
  Future<List<SummaryClub>> getLoggedInAthleteClubs(int page, int perPage) {
    return ApiClient.getRequest(
        endPoint: "v3/athlete/clubs",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) => SummaryClub.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<SummaryActivity>> listClubActivities(
      int clubId, int page, int perPage) {
    return ApiClient.getRequest(
        endPoint: "v3/clubs/$clubId/activities",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) =>
                    SummaryActivity.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<SummaryAthlete>> listClubAdministrators(
      int clubId, int page, int perPage) {
    return ApiClient.getRequest(
        endPoint: "v3/clubs/$clubId/admins",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) =>
                    SummaryAthlete.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
          return [];
        });
  }

  @override
  Future<List<SummaryAthlete>> listClubMembers(
      int clubId, int page, int perPage) {
    return ApiClient.getRequest(
        endPoint: "v3/clubs/$clubId/members",
        dataConstructor: (data) {
          if (data is List) {
            return data
                .map((e) =>
                    SummaryAthlete.fromJson(Map<String, dynamic>.from(e)))
                .toList();
          }
          return [];
        });
  }
}
