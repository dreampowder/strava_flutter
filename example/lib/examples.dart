// Examples to use strava_flutter
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
    final strava = Strava(true, // To get display info in API
         secret);

    bool isAuthOk = false;

    isAuthOk = await strava.Oauth(clientId, 'activity:write', secret, 'auto');

    print('---> Authentication result: $isAuthOk');

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


///
/// Example of dart code to use Strava API
/// 
/// set isInDebug to true in strava init to see the debug info 
void example(String secret) async {

    bool isAuthOk = false;

    final strava = Strava(false,
         secret);
    final prompt = 'auto';

    isAuthOk = await strava.Oauth(clientId, 'activity:write,profile:read_all', secret, prompt);

    if (isAuthOk) {

      // Type of expected answer:
      // {"id":25707617,"username":"patrick_ff","resource_state":3,"firstname":"Patrick","lastname":"FF",
      // "city":"Le Beausset","state":"Provence-Alpes-Côte d'Azur","country":"France","sex":null,"premium"
      DetailedAthlete _athlete = await strava.getLoggedInAthlete();
      if (_athlete.fault.statusCode != strava.statusOk) {
        print('Error in getloggedInAthlete ${_athlete.fault.statusCode}');
      }

      // Type of expected answer 
      //  {"biggest_ride_distance":156733.0,"biggest_climb_elevation_gain":null,"recent_ride_totals":{"count":2,"distance":111427.7001953125,
      // "moving_time":17726,"elapsed_time":23181,"elevation_gain":1354.5838375091553,"achievement_count":0},"recent_run_to
      Stats _stats = await strava.getStats(_athlete.id);
      if (_stats.fault.statusCode != strava.statusOk) {
          print('Error in getloggedInAthlete ${_stats.fault.statusCode}');
      }
    
      // A long list of races per city
      // Starting by Walt Disney World Marathon
      List<RunningRace> listRunningRaces = await strava.getRunningRaces('2019');
      if ((listRunningRaces == null) || (listRunningRaces[0].fault.statusCode != strava.statusOk)) {
        print('Error in getRunningRaces: ${listRunningRaces[0].fault.statusCode}');
      }

      // id corresponding to BMW Berlin Marathon 29th Sept 2019
      RunningRace race = await strava.getRunningRaceById('2724');

      // Change weight of the loggedAthlete in profile (in kg)
      DetailedAthlete athlete2 = await strava.updateLoggedInAthlete(84);
      

      /// Gear should be owned by the loggedIn Athleted
      /// Type of expected answer:
      /// {"id":"b4366285","primary":true,"name":"Roubaix Specialized","resource_state":3,"distance":461692.0,
      /// "brand_name":"Specialized","model_name":"Roubaix Expert","frame_type":3,"description":"So comfortable!"}
      Gear _gear = await strava.getGearById("b4366285");
      if (_gear.fault.statusCode != strava.statusOk) {
         print('error code getGearById  ${_gear.fault.statusCode}');
      }

      //  You have to join this club to do the test
      final clubStravaMarseille =
          '226910';
      /// Answer expected:
      /// {"id":226910,"resource_state":3,"name":"STRAVA Marseille ",
      /// "profile_medium":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/226910/5003423/3/medium.jpg","profile":"https://dgalywyr863hv.cloudfront.net/pictures/clubs/226910/5003423/3/larg
      Club club = await strava.getClubById(clubStravaMarseille);

    
      /// List the member of Strava club
      /// Expected answer (should start like this):
      ///  [{"resource_state":2,"firstname":"Adam","lastname":"Š.","membership":"member",
      /// "admin":false,"owner":false},{"resource_state":2,"firstname":"Alex","lastname":"M.","membership"
      List<SummaryAthlete> listMembers = await strava.getClubMembersById('1');

      // List<Zone> list = await strava.getLoggedInAthleteZones();

      List<SummaryActivity> listSumm =
          await strava.getClubActivitiesById(clubStravaMarseille);


       /// You have to put an id of one activity of the logged Athlete 
       /// You can find the id of one activity looking at your web page
       /// https://www.strava.com/activities/2130215349
      DetailedActivity _activity = await strava.getActivityById('2130215349');
      if (_activity.fault.statusCode != strava.statusOk) {
        print('Error in getActivityById: ${_activity.fault.statusCode}');

      }
    }
  }

