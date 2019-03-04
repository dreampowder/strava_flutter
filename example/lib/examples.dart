// examples to use strava_flutter
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data'; // Needed when declaring ByteData


import 'package:strava_flutter/API/constants.dart';

// Used by uploadExample
import 'package:strava_flutter/API/strava.dart';
import 'package:strava_flutter/Models/fault.dart';
import 'package:strava_flutter/API/token.dart';


// Used by example
import 'package:strava_flutter/Models/detailedActivity.dart';
import 'package:strava_flutter/Models/club.dart';
import 'package:strava_flutter/Models/detailedAthlete.dart';
import 'package:strava_flutter/Models/gear.dart';
import 'package:strava_flutter/Models/runningRace.dart';
import 'package:strava_flutter/Models/stats.dart';
import 'package:strava_flutter/Models/summaryAthlete.dart';
import 'package:strava_flutter/Models/summaryActivity.dart';




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
         secret, 'auto');

    bool isAuthOk = false;

    isAuthOk = await strava.OAuth(clientID, "http://localhost:8080", 'activity:write', secret);

    print('---> thats it!!, $isAuthOk');

    Token tokenStored = await strava.getStoredToken();
   

    // Use the asset file to test without having to create internally a ride
    //----------------------------------------------------------------------
    String dir = (await getApplicationDocumentsDirectory()).path;
    var data = await rootBundle.load('assets/Bormes.gpx');
    // Save the data loaded from the assert into a file
    // Transfer the data into a real file
    await writeToFile(data, '$dir/myActivity.gpx');

    Fault fault = await strava.uploadActivity('Bormes3', 'It is working!', '$dir/myActivity.gpx',
        'gpx', tokenStored.accessToken);

    return fault;
  }




void example(String secret) async {

    bool isAuthOk = false;

    final strava = Strava(
         secret, 'auto');

    isAuthOk = await strava.OAuth(clientID, "http://localhost:8080", 'activity:write', secret);

    if (isAuthOk) {

      DetailedAthlete _athlete = await strava.getLoggedInAthlete();
      if (_athlete.fault.statusCode != strava.statusOk) {

        print('Error in getloggedInAthlete ${_athlete.fault.statusCode}');
      }
    

      List<RunningRace> listRunningRaces = await strava.getRunningRaces("2019");

      // id corresponding to BMW Berlin Marathon 29th Sept 2019
      RunningRace race = await strava.getRunningRaceById('2724');

      // Change of the loggedAthlete in profile
      DetailedAthlete athlete2 = await strava.updateLoggedInAthlete(84);
      

      Gear gear = await strava.getGearById("b4366285");
      // print('error code getGearById  ${gear.errorCode}');

      Stats stats = await strava.getStats(_athlete.id);

      // List<Zone> list = await strava.getLoggedInAthleteZones();

      final clubStravaMarseille =
          '226910'; // You have to join this club to do the test

      Club club = await strava.getClubById(clubStravaMarseille);

      // Test getActivityById
      DetailedActivity _activity = await strava.getActivityById('2131889191');

      List<SummaryAthlete> listMembers = await strava.getClubMembersById('1');

      List<SummaryActivity> listSumm =
          await strava.getClubActivitiesById(clubStravaMarseille);
    }
  }

