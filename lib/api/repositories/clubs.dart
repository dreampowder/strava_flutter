// clubs.dart
import 'package:http/http.dart' as http;
import 'package:strava_flutter/api/client.dart';
import 'package:strava_flutter/models/old_summary_activity.dart';
import 'package:strava_flutter/models/summary_activity.dart';
import 'dart:convert';
import 'dart:async';

import 'package:strava_flutter/models/summary_athlete.dart';
import 'package:strava_flutter/models/activity.dart';
import 'package:strava_flutter/models/club.dart';
import 'package:strava_flutter/models/fault.dart';

import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/error_codes.dart' as error;

abstract class ClubsRepository {
  ///  Scope needed:
  /// id of the club
  /// No need to be member of the club
  Future<List<SummaryAthlete>> getClubMembersById(String clubId) async {
    return ApiClient.getRequest(
        endPoint: "/v3/clubs/$clubId/members",
        dataConstructor: (data){
          if(data is List){
            return data.map((e) => SummaryAthlete.fromJson(Map<String,dynamic>.from(e))).toList();
          }
          return [];
        });
  }

  /// scope
  ///
  Future<Club> getClubById(int clubId) async {
    return ApiClient.getRequest(
        endPoint: "/v3/clubs/$clubId",
        dataConstructor: (data){
          return Club.fromJson(data);
        });
  }

  /// Need to be member of the club
  ///
  Future<List<SummaryActivity>> getClubActivitiesById(int clubId,
      {int page = 1, int pageSize = 30}) async {
    return ApiClient.getRequest(
        endPoint: "/v3/clubs/$clubId/activities",
        queryParameters: {
          "page":page,
          "per_page":pageSize
        },
        dataConstructor: (data){
          if(data is List){
            print("data: $data");
            return data.map((e) => SummaryActivity.fromJson(Map<String,dynamic>.from(e))).toList();
          }
          return [];
        });
  }
}
