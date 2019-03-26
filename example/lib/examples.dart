// examples.dart

// Examples to use strava_flutter
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data'; // Needed when declaring ByteData

import 'package:strava_flutter/API/constants.dart';

// Used by uploadExample
import 'package:strava_flutter/strava.dart';
import 'package:strava_flutter/Models/fault.dart';
import 'package:strava_flutter/Models/token.dart';

// Used by segment
import 'package:strava_flutter/Models/segment.dart';

/// Example showing how to upload an activity on Strava
///
/// Use file Bormes.gpx in assets
///
/// Should appear on your activities 6 Feb. 2018
///
/// Under the title Bormes3
///
Future<Fault> exampleUpload(String secret) async {
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  // Do authentication with the right scope
  final strava = Strava(
      true, // To get display info in API
      secret);

  bool isAuthOk = false;

  isAuthOk = await strava.oauth(clientId, 'activity:write', secret, 'auto');

  print('---> Authentication result: $isAuthOk');

  // Use the asset file to test without having to create internally a ride
  //----------------------------------------------------------------------
  String dir = (await getApplicationDocumentsDirectory()).path;

  var data = await rootBundle.load('assets/Bormes.gpx');
  // Save the data loaded from the asset into a file
  // Transfer the data into a real file
  await writeToFile(data, '$dir/myActivity.gpx');

  Fault fault = await strava.uploadActivity(
      'Bormes26', 'It is working!', '$dir/myActivity.gpx', 'gpx');

  return fault;
}

///
/// Example showing how to use Strava 3 API
/// related to segments
///
Future<Fault> exampleSegment(String secret) async {
  // Do authentication with the right scope
  final strava = Strava(
      true, // To get display info in API
      secret);

  bool isAuthOk = false;

  isAuthOk = await strava.oauth(
      clientId, 'profile:write,profile:read_all', secret, 'auto');

  print('---> Authentication result: $isAuthOk');

  // Expected answer should start like:
  //  {"id":229781,"resource_state":3,"name":"Hawk Hill","activity_type":"Ride","distance":2684.82,"average_grade":5.7,"maximum_grade":14.2,
  DetailedSegment _seg = await strava.getSegmentById('229781');
  print(' segment $_seg');

  DetailedSegment _seg2 = await strava.getSegmentById('8186850');
  print(' segment $_seg');

  // Get the list of segments that have been starred by the loggedin athlete
  SegmentsList _list = await strava.getLoggedInAthleteStarredSegments();

  _list.segments.forEach((seg) =>
      print('Starred segment: ${seg.id}  ${seg.name} ${seg.maximumGrade}'));

  // Get the leaderboard for a specific segment 8186850
  // There are optional parameters
  // Expected answer should start like:
  // Leaderboard entry Jeremy B.  666
  //  Leaderboard entry Robin B.  668
  //  Leaderboard entry Michiel M.  668
  // Leaderboard entry Arno D.  668
  // Leaderboard entry Pottier C.  668
  // Leaderboard entry Damien L.  668
  // Leaderboard entry David D.  668
  // Leaderboard entry David D.  668
  // Leaderboard entry David P.  669
  SegmentLeaderboard _leaderboard =
      await strava.getLeaderboardBySegmentId(8186850);
  _leaderboard.entries.forEach(
      (f) => print('Leaderboard entry ${f.athleteName}  ${f.elapsedTime}'));

  /// Star (or unstar) a segment for the loggedInAthlete
  ///

//   NOT working for the moment
  // DetailedSegment _segmentStarred = await strava.starSegment(8186850, true);
  // DetailedSegment _segmentStarred = await strava.starSegment(8186850, true);

  // print('new starred segment ${_segmentStarred.id}  ${_segmentStarred.name}  starred: ${_segmentStarred.starred}');
}
