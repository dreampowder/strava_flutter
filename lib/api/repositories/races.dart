// races.dart

import 'package:http/http.dart' as http;
import 'package:strava_flutter/api/client.dart';
import 'dart:convert';
import 'dart:async';

import 'package:strava_flutter/models/running_race.dart';
import 'package:strava_flutter/models/fault.dart';

import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/error_codes.dart' as error;

abstract class Races {
  /// getRunningRacebyId
  ///
  /// Scope needed: none
  ///
  /// Answer has route_ids [int]
  Future<RunningRace> getRunningRaceById(String id) async {
    return ApiClient.getRequest(
        endPoint: "/v3/running_races/$id",
        dataConstructor: (data)=>RunningRace.fromJson(Map<String,dynamic>.from(data)
        ));
  }

  /// Scope needed: none
  /// Answer has NO route_ids for the moment
  Future<List<RunningRace>> getRunningRaces(String year) async {
    return ApiClient.getRequest(
        endPoint: "/v3/running_races",
        queryParameters: {
          "year":year
        },
        dataConstructor: (data){
          if(data is List){
            return data.map((e) => RunningRace.fromJson(Map<String,dynamic>.from(e))).toList();
          }
          return [];
        });
  }
}
