// globals.dart

import 'package:flutter/foundation.dart';
import 'Models/fault.dart';
import 'Models/token.dart';

bool isInDebug = true; // set to true to see debug message in API

Token token = Token(); // Where the token info is stored when executing APIs

/// Not used anymore
/// List of statuscode used by Fault
/// used by Strava API
final statusOk = 0;
final statusInvalidToken = 1;
final statusUnknownError = 2;
final statusHeaderIsEmpty = 3;
final statusNotFound = 4;

// Default location
// used when an activity has null
// for startLatitude and end
final defaultStartLatlng = 0.0;
final defaultEndlatlng = 0.0;

// To display debug info in Strava API
void displayInfo(String message) {
  if (isInDebug) {
    var msgToDisplay = '--> Strava_flutter: ' + message;
    debugPrint(msgToDisplay);
  }
}

Map<String, String> createHeader() {
  var _token = token;
  if (_token != null) {
    return {'Authorization': 'Bearer ${_token.accessToken}'};
  } else {
    return {null: null};
  }
}

/// Nothing much inside for the moment
/// Feed the Fault with statusCode and reasonPhrase
/// Coming from http request
///
Fault errorCheck(int statusCode, String reason) {
  Fault returnFault = Fault(statusCode, reason);

  return returnFault;
}
