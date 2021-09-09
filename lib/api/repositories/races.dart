// races.dart

import 'dart:async';

import 'package:strava_flutter/data/repository/client.dart';
import 'package:strava_flutter/models/running_race.dart';

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
