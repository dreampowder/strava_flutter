/// segments.dart
///
///
///

import 'package:http/http.dart' as http;
import 'package:strava_flutter/api/client.dart';
import 'dart:convert';
import 'dart:async';

import 'package:strava_flutter/models/segment.dart';
import 'package:strava_flutter/models/fault.dart';

import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/error_codes.dart' as error;

abstract class Segments {
  ///
  /// scope needed: read_all
  ///
  Future<DetailedSegment> getSegmentById(String id) async {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/$id",
        dataConstructor: (data)=>DetailedSegment.fromJson(Map<String,dynamic>.from(data)));
  }

  ///
  /// Scope needed: read_all
  ///
  /// List of segments starred by the authenticated athlete
  ///
  /// Limited for the moment to the first 50 starred segments
  ///
  Future<List<SummarySegment>?> getLoggedInAthleteStarredSegments({int page = 1,int pageSize = 30}) async {
    return ApiClient.getRequest(
        endPoint: "/v3/segments/starred",
        queryParameters: {
          "page":page,
          "per_page":pageSize
        },
        dataConstructor: (data){
          if(data is List){
            return data.map((e) => SummarySegment.fromJson(Map<String,dynamic>.from(e))).toList();
          }
          return [];
        });
  }

  // Future<SegmentLeaderboard> getLeaderBoardForSegmentId(
  //     int id,
  //     int clubId,
  //     int maxEntries,
  //     bool isFollowing,
  //     SegmentGender gender,
  //     SegmentAgeGroup ageGroup,
  //     SegmentWeightClass weightClass,
  //     SegmentDateRange dateRange,
  //     {
  //       int page = 1,
  //       int pageSize = 30
  //     }
  //     ){
  //   return ApiClient.getRequest(
  //       endPoint: "https://www.strava.com/api/v3/segments/$id",
  //       queryParameters: {
  //         "gender":gender.toString().replaceAll("SegmentGender.", ""),
  //         "age_group":ageGroup.toString().replaceAll("SegmentAgeGroup.AgeGroup_", ""),
  //         "weight_class":weightClass.toString().replaceAll("SegmentWeightClass.WeightClass_", ""),
  //         "club_id":clubId,
  //         "following":isFollowing,
  //         "date_range":dateRange.toString().replaceAll("SegmentDateRange.", ""),
  //         "page":page,
  //         "per_page":pageSize,
  //         "context":""
  //       },
  //       dataConstructor: (data)=>SegmentLeaderboard.fromJson(Map<String,dynamic>.from(data))
  //   );
  // }

  /// scoped needed: ?
  ///
  /// nbEntries: to limit the number of entries to retrieve.
  /// 0 means full list
  ///
  /// No check is done on the parameters
  ///
  /// gender value : M of F
  ///
  /// age_group and weight class NEED summit subscription from LoggedInAthlete
  ///
  /// age_group value : 0_19, 20_24, 25_34, 35_44, 45_54, 55_64, 65_69, 70_74, 75_plus
  ///
  /// weight_class value : 0_124, 125_149, 150_164, 165_179, 180_199, 200_224, 225_249, 250_plus,
  ///  0_54, 55_64, 65_74, 75_84, 85_94, 95_104, 105_114, 115_plus
  ///
  /// date_range value : this_year, this_month, this_week, today
  ///
  /// Not clear what is the purpose of context entries
  ///
  Future<SegmentLeaderboard> getLeaderboardBySegmentId(
    int? id, {
    int? nbMaxEntries,
    String? gender,
    String? ageGroup,
    String? weightclass,
    bool? following,
    int? clubId,
    String? dateRange,
  }) async {
    SegmentLeaderboard returnLeaderboard;
    returnLeaderboard = SegmentLeaderboard();
    final _header = globals.createHeader();
    int _pageNumber = 1;
    int _perPage = 50; // Number of activities retrieved per http request
    bool isRetrieveDone = false;
    int _nbEntries = 0;
    List<Entries> _listEntries = <Entries>[];

    globals.displayInfo('Entering getLeaderboardBySegmentId');

    // fix optional parameters when their value is null
    nbMaxEntries = nbMaxEntries ?? 2 ^ 63;
    gender = gender ?? 'M';
    ageGroup = ageGroup ?? '';
    weightclass = weightclass ?? '';
    following = following ?? false;
    final clubIdStr = (clubId != null) ? clubId.toString() : '';
    dateRange = dateRange ?? '';

    if (_header.containsKey('88') == false) {
      do {
        String reqLeaderboard = 'https://www.strava.com/api/v3/segments/' +
            id.toString() +
            '/leaderboard?=gender' +
            gender +
            '&age_group=' +
            ageGroup +
            '&weight_class=' +
            weightclass +
            '&following=' +
            following.toString() +
            '&club_id=' +
            clubIdStr +
            '&date_range=' +
            dateRange +
            '&context_entries=' +
            '&page=$_pageNumber&per_page=$_perPage';

        final rep = await http.get(Uri.parse(reqLeaderboard), headers: _header);

        if (rep.statusCode == 200) {
          globals.displayInfo(rep.statusCode.toString());
          globals.displayInfo('Leaderboard info ${rep.body}');

          final Map<String, dynamic>? jsonResponse = json.decode(rep.body);
          if (jsonResponse != null) {
            returnLeaderboard = SegmentLeaderboard.fromJson(json.decode(rep.body));

            // Add entries to the list
            returnLeaderboard.entries?.forEach((ent) {
              if (_nbEntries < nbMaxEntries!) {
                _listEntries.add(ent);
                _nbEntries++;
              }
            });

            globals.displayInfo('Entries ${_listEntries.length}');

            if ((_listEntries.length >= returnLeaderboard.entryCount!) ||
                (_listEntries.length >= nbMaxEntries)) {
              globals.displayInfo(
                  '----> End of leaderboard   ${returnLeaderboard.entryCount}');
              isRetrieveDone = true;
              returnLeaderboard.entries = _listEntries;
            } else {
              _pageNumber++;
            }
          } else {
            globals.displayInfo('problem in getLeaderboardBySegmentId request');
          }

          returnLeaderboard.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
        }
      } while (!isRetrieveDone);
    } else {
      globals.displayInfo('Token not yet known');
      returnLeaderboard.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }
    return returnLeaderboard;
  }

  /// starSegment
  ///
  /// scope needed: activity:write
  ///
  /// star : true to star false to unstar
  ///
  Future<DetailedSegment> starSegment(int? id, bool star) async {
    DetailedSegment returnSegment;

    returnSegment = DetailedSegment();
    final _header = globals.createHeader();
    // String toStarred = star ? 'true' : 'false';
    // final _queryParams = {'starred': toStarred};

    globals.displayInfo('Entering starSegment');

    if (_header.containsKey('88') == false) {
      final reqStar = 'https://www.strava.com/api/v3/segments/' +
          id.toString() +
          '/starred?starred=' +
          star.toString();
      final rep = await http.put(Uri.parse(reqStar), headers: _header);

      // final uri = Uri.https('www.strava.com', path);

      // final rep = await http.put(    uri,   headers: _header,  );
      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Star segment  info ${rep.body}');
        returnSegment = DetailedSegment.fromJson(json.decode(rep.body));
      } else {
        globals.displayInfo('Problem in starSegment request');
      }
      returnSegment.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnSegment.fault = Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }
    return returnSegment;
  }
}

enum SegmentGender{
  male, female
}

enum SegmentAgeGroup{
  AgeGroup_0_19,
  AgeGroup_20_24,
  AgeGroup_25_34,
  AgeGroup_35_44,
  AgeGroup_45_54,
  AgeGroup_55_64,
  AgeGroup_65_69,
  AgeGroup_70_74,
  AgeGroup_75_plus
}

enum SegmentWeightClass{
  WeightClass_0_124,
  WeightClass_125_149,
  WeightClass_150_164,
  WeightClass_165_179,
  WeightClass_180_199,
  WeightClass_200_224,
  WeightClass_225_249,
  WeightClass_250_plus,
  WeightClass_0_54,
  WeightClass_55_64,
  WeightClass_65_74,
  WeightClass_75_84,
  WeightClass_85_94,
  WeightClass_95_104,
  WeightClass_105_114,
  WeightClass_115_plus
}

enum SegmentDateRange{
  this_year, this_month, this_week, today
}