// globals.dart 

import 'token.dart';

bool isInDebug = true;  // set to true to see debug message in API 

Token token = Token();

// To display debug info in Strava API
void displayInfo(String message) {
    if (isInDebug) {
      var msgToDisplay = '--> Strava_flutter: ' + message;
      print(msgToDisplay);
    }

  }