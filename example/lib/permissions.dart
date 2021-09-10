// permissions.dart
// Test when some permissions are incorrect
// For the moment only
// getLoggedInAthleteActivities

import 'dart:async';

import 'package:strava_flutter/error_codes.dart' as error;
import 'package:strava_flutter/models/fault.dart';
import 'package:strava_flutter/strava.dart';

import 'secret.dart';

Future<Fault> testPermissions(String secret) async {
// Do authentication with the right scope
  final strava = Strava(
      true, // To get display info in API
      secret);

  Fault _fault = Fault(error.statusOk, '');

  bool isAuthOk = false;

  // activity: read_all is missing

  isAuthOk = await strava.oauth(
      // clientId, 'profile:write,profile:read_all', secret, 'auto');
      clientId,
      // 'profile:write,profile:read_all,activity:read_all',
      'profile:write,profile:read_all',
      secret,
      'auto');

  print('---> Authentication result: $isAuthOk');

  // List<SummaryActivity> _listSummaries =
  //     await strava.getLoggedInAthleteActivities(1554209575, 1500);

  return _fault;
}
