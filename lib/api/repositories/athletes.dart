// athletes.dart

import 'package:http/http.dart' as http;
import 'package:strava_flutter/api/client.dart';
import 'dart:convert';
import 'dart:async';

import 'package:strava_flutter/models/stats.dart';
import 'package:strava_flutter/models/detailed_athlete.dart';
import 'package:strava_flutter/models/summary_activity.dart';
import 'package:strava_flutter/models/zone.dart';
import 'package:strava_flutter/models/activity.dart';
import 'package:strava_flutter/models/fault.dart';

import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/error_codes.dart' as error;

abstract class AthletesRepository {

  ///Updated Athelete Weight
  ///Scope: [profile:write]
  ///[weight] weight in kilograms (double)
  Future<DetailedAthlete> updateLoggedInAthlete(double weight) async {
    return ApiClient.putRequest<DetailedAthlete>(
        endPoint: "/v3/athlete",
        queryParameters: {
          "weight":weight
        },
        dataConstructor: (data)=>DetailedAthlete.fromJson(data));
  }

  /// Give activiy stats of the loggedInAthlete
  /// [athleteId] athelete Id to query
  Future<Stats> getStats(int athleteId) async {
    return ApiClient.getRequest(
        endPoint: "/v3/athletes/$athleteId/stats",
        dataConstructor: (data)=>Stats.fromJson(data));
  }

  /// Provide zones heart rate or power for the logged athlete
  ///
  /// scope needed: profile:read_all
  Future<List<Zone>> getLoggedInAthleteZones() async {
    return ApiClient.getRequest<List<Zone>>(
        endPoint: "/v3/athlete/zones",
        dataConstructor: (data){
          if(data is List){
            return data.map((e) => Zone.fromJson(Map<String,dynamic>.from(e))).toList();
          }else{
            return [];
          }
        });
  }

  /// scope needed: profile:read_all scope
  /// return: see status value in strava class
  Future<DetailedAthlete> getLoggedInAthlete() async {
    return ApiClient.getRequest<DetailedAthlete>(
        endPoint: "/v3/athlete",
        dataConstructor: (data){
          print("Athlete: $data");
          return DetailedAthlete.fromJson(data);
        });
  }

  /// scope needed: profile: activity:read_all
  /// parameters:
  /// before: since time epoch in seconds
  /// after: since time epoch in seconsd
  ///
  /// return: a list of activities related to the logged athlete
  ///  null if the authentication has not been done before
  ///
  Future<List<SummaryActivity>?> getLoggedInAthleteActivities(
      int before, int after) async {
    return ApiClient.getRequest(
        endPoint: "/v3/athlete/activities",
        dataConstructor: (data){
          if(data is List){
            return data.map((e) => SummaryActivity.fromJson(Map<String,dynamic>.from(e))).toList();
          }
          return [];
        });
  }
}
