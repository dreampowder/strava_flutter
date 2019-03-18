/// segments.dart
///
///
///

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/segment.dart';

import 'globals.dart' as globals;

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
        var parsedJson = json.decode(rep.body);
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
}
