// examples.dart

// Examples to use strava_flutter
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data'; // Needed when declaring ByteData

// import 'package:strava_flutter/API/constants.dart';
import 'package:strava_flutter/errorCodes.dart' as error;
import 'secret.dart';

// Used by uploadExample
import 'package:strava_flutter/strava.dart';
import 'package:strava_flutter/Models/fault.dart';
import 'package:strava_flutter/Models/stats.dart'; // Test

// Used by segment and segmentEffort
import 'package:strava_flutter/Models/segment.dart';
import 'package:strava_flutter/Models/segmentEffort.dart';

// To test getLoggedInAtletheActivities
import 'package:strava_flutter/Models/detailedAthlete.dart';
import 'package:strava_flutter/Models/activity.dart';

/// Example showing how to upload an activity on Strava
///
/// Use file Bormes.gpx in assets
///
/// Should appear on your activities 6 Feb. 2019
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
  Fault _fault = Fault(error.statusOk, '');

  bool isAuthOk = false;

  isAuthOk = await strava.oauth(clientId, 'activity:write', secret, 'auto');

  print('---> Authentication result: $isAuthOk');

  if (isAuthOk == false) {
    _fault.statusCode = error.statusAuthError;
    _fault.message = 'Authentication has not been succesful';
    return _fault;
  }

  // Use the asset file to test without having to create internally a ride
  //----------------------------------------------------------------------
  String dir = (await getApplicationDocumentsDirectory()).path;

  var data = await rootBundle.load('assets/Bormes.gpx');
  // Save the data loaded from the asset into a file
  // Transfer the data into a real file
  await writeToFile(data, '$dir/myActivity.gpx');

  Fault fault = await strava.uploadActivity(
      'Bormes16', 'It is working!', '$dir/myActivity.gpx', 'gpx');

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

  Fault _fault = Fault(error.statusOk, '');

  bool isAuthOk = false;

  isAuthOk = await strava.oauth(clientId,
      'profile:write,profile:read_all,activity:read_all', secret, 'auto');

  print('---> Authentication result: $isAuthOk');

  DetailedAthlete _detailedAthlete = await strava.getLoggedInAthlete();

  // Stats _stats = await strava.getStats(32212);
  Stats _stats = await strava.getStats(_detailedAthlete.id);

  if (_stats.fault.statusCode == error.statusTokenNotKnownYet) {
    print('status code ${_stats.fault.message}');
  }

  print('Test getEffortById');
  // It is the segment id that you can find in an activity
  // Like what is after segment in url like
  // https://www.strava.com/activities/3234026164/segments/81425019085
  DetailedSegmentEffort _segEffort =
      await strava.getSegmentEffortById(81425019085);

  print('Test getEffortsbySegmentId');
  // The loggedInAthlete should have ridden the segment
  // if not _segEfforts.statusCode == error.statusSegmentNotRidden
  // To get the id it is after segments in url like
  // https://www.strava.com/segments/3915689?filter=overall
  DetailedSegmentEffort _segEfforts = await strava.getEffortsbySegmentId(
    2709373,
    '2018-09-15T08:15:29Z',
    '2020-05-16T08:15:29Z',
  );

  List<SummaryActivity> _listSummaries =
      await strava.getLoggedInAthleteActivities(1554209575, 1500);

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

  // Get the leaderboard for a specific segment 2628520
  // Less than 100 entries
// I/flutter (30397): Leaderboard entry Red  M.  706
// I/flutter (30397): Leaderboard entry Kyle M.  783
// I/flutter (30397): Leaderboard entry Mike H.  797
// I/flutter (30397): Leaderboard entry J Darcy K.  815
// I/flutter (30397): Leaderboard entry A P.  873
// I/flutter (30397): Leaderboard entry Tj C.  919
// I/flutter (30397): Leaderboard entry Tom P.  922
// I/flutter (30397): Leaderboard entry Rick I.  939
// I/flutter (30397): Leaderboard entry Trevar B.  961
// I/flutter (30397): Leaderboard entry Brian L.  974
// I/flutter (30397): Leaderboard entry Duke N.  983
// I/flutter (30397): Leaderboard entry Stephanie  W.  1008

  SegmentLeaderboard _leaderboard =
      await strava.getLeaderboardBySegmentId(8186850, nbMaxEntries: 10);
  // await strava.getLeaderboardBySegmentId(2628520);
  _leaderboard.entries.forEach(
      (f) => print('Leaderboard entry ${f.athleteName}  ${f.elapsedTime}'));

  /// Star (or unstar) a segment for the loggedInAthlete
  ///
  DetailedSegment _segmentStarred = await strava.starSegment(8186850, true);

  print(
      'new starred segment ${_segmentStarred.id}  ${_segmentStarred.name}  starred: ${_segmentStarred.starred}');

  return _fault;
}
