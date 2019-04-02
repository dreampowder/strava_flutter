/// segments.dart
///
///
///

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/segment.dart';

import '../globals.dart' as globals;

abstract class Segments {
  ///
  /// scope needed: read_all
  ///
  Future<DetailedSegment> getSegmentById(String id) async {
    DetailedSegment returnSeg;

    var _header = globals.createHeader();

    globals.displayInfo('Entering getSegById');

    if (_header != null) {
      final reqSeg = 'https://www.strava.com/api/v3/segments/' + id;
      var rep = await http.get(reqSeg, headers: _header);
      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Segment info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        DetailedSegment _seg = DetailedSegment.fromJson(jsonResponse);
        globals.displayInfo(_seg.name);

        returnSeg = _seg;
      } else {
        globals.displayInfo('problem in getSegById request');

        // 404 : segment not found
      }
    }
    return returnSeg;
  }

  ///
  /// Scope needed: read_all
  ///
  /// List of segments starred by the authenticated athlete
  ///
  /// Limited for the moment to the first 50 starred segments
  ///
  Future<SegmentsList> getLoggedInAthleteStarredSegments() async {
    SegmentsList returnList;

    returnList = SegmentsList();
    var _header = globals.createHeader();

    globals.displayInfo('Entering getLoggedInAthleteStarredSegments');

    if (_header != null) {
      final reqSeg =
          'https://www.strava.com/api/v3/segments/starred?page=1&per_page=50';
      var rep = await http.get(reqSeg, headers: _header);
      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('List starred segments  info ${rep.body}');
        // var parsedJson = json.decode(rep.body);
        returnList = SegmentsList.fromJson(json.decode(rep.body));
      } else {
        globals.displayInfo(
            'problem in getLoggedInAthleteStarredSegments request');
        // Add a fault
        returnList = null;
      }
    }
    return returnList;
  }

  /// scoped needed: ?
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
  /// Limited for the moment to the first 50 atheletes
  /// Not clear what is the purpose of context entries
  ///
  Future<SegmentLeaderboard> getLeaderboardBySegmentId(int id,
      {String gender,
      String ageGroup,
      String weightclass,
      bool following,
      int clubId,
      String dateRange}) async {
    SegmentLeaderboard returnLeaderboard;

    returnLeaderboard = SegmentLeaderboard();
    var _header = globals.createHeader();

    globals.displayInfo('Entering getLeaderboardBySegmentId');

    // fix optional parameters when their value is null
    gender = gender ?? 'M';
    ageGroup = ageGroup ?? '';
    weightclass = weightclass ?? '';
    following = following ?? false;
    var clubIdStr = (clubId != null) ? clubId.toString() : '';
    dateRange = dateRange ?? '';



    if (_header != null) {
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
          '&page1=&per_page=50';

      var rep = await http.get(reqLeaderboard, headers: _header);
      if (rep.statusCode == 200) {
        SegmentLeaderboard _tempLeaderboard;
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Leaderboard info ${rep.body}');
        // var parsedJson = json.decode(rep.body);
        returnLeaderboard = SegmentLeaderboard.fromJson(json.decode(rep.body));
        // _tempLeaderboard = SegmentLeaderboard.fromJson(json.decode(rep.body));
        // returnLeaderboard.entries = _tempLeaderboard.entries.toList();
      } else {
        globals.displayInfo('problem in getLeaderboardBySegmentId request');
      }

      returnLeaderboard.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }
    return returnLeaderboard;
  }

  /// starSegment
  ///
  /// scope needed: activity:write
  ///
  /// star : true to star false to unstar
  ///
  Future<DetailedSegment> starSegment(int id, bool star) async {
    DetailedSegment returnSegment;

    returnSegment = DetailedSegment();
    var _header = globals.createHeader();
    // String toStarred = star ? 'true' : 'false';
    // var _queryParams = {'starred': toStarred};

    globals.displayInfo('Entering starSegment');

    if (_header != null) {
      final path = '/api/v3/segments/' + id.toString() + '/starred';

      var uri = Uri.https('www.strava.com', path);

      var rep = await http.put(
        uri,
        headers: _header,
      );
      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Star segment  info ${rep.body}');
        returnSegment = DetailedSegment.fromJson(json.decode(rep.body));
      } else {
        globals.displayInfo('Problem in starSegment request');
      }
      returnSegment.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }
    return returnSegment;
  }
}
