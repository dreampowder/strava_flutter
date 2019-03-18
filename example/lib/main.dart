import 'package:flutter/material.dart';


import 'examples.dart';

import 'secret.dart'; // Where Strava app secret is stored

import 'package:strava_flutter/API/strava.dart';
import 'package:strava_flutter/API/constants.dart';
import 'package:strava_flutter/API/globals.dart' as globals;

// Used by example

import 'package:strava_flutter/Models/detailedActivity.dart';
import 'package:strava_flutter/Models/club.dart';
import 'package:strava_flutter/Models/detailedAthlete.dart';
import 'package:strava_flutter/Models/gear.dart';
import 'package:strava_flutter/Models/runningRace.dart';
import 'package:strava_flutter/Models/stats.dart';
import 'package:strava_flutter/Models/summaryAthlete.dart';
import 'package:strava_flutter/Models/summaryActivity.dart';



Strava strava;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strava Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StravaFlutterPage(title: 'strava_flutter demo'),
    );
  }
}

class StravaFlutterPage extends StatefulWidget {
  StravaFlutterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StravaFlutterPageState createState() => _StravaFlutterPageState();
}

class _StravaFlutterPageState extends State<StravaFlutterPage> {


  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  

  void exampleStrava() {

    example(secret);
  }


  void exampleSeg() {

    exampleSegment(secret);


  }



///
/// Example of dart code to use Strava API
/// 
/// set isInDebug to true in strava init to see the debug info 
void example(String secret) async {

    bool isAuthOk = false;

    final strava = Strava(true,
         secret);
    final prompt = 'auto';

    isAuthOk = await strava.Oauth(clientId, 'activity:write,profile:read_all', secret, prompt);

    if (isAuthOk) {


/**** Not yet working!
      // Create an new activity
      String _startDate = '20190316T093500+0100';
      DetailedActivity _newActivity = await strava.createActivity('Test3', 'Run', _startDate, 3600);
      if (_newActivity.fault.statusCode !=globals.statusOk ) {
        print('Error in createActivity ${_newActivity.fault.statusCode}');

      }
****/


      // Type of expected answer:
      // {"id":25707617,"username":"patrick_ff","resource_state":3,"firstname":"Patrick","lastname":"FF",
      // "city":"Le Beausset","state":"Provence-Alpes-Côte d'Azur","country":"France","sex":null,"premium"
      DetailedAthlete _athlete = await strava.getLoggedInAthlete();
      if (_athlete.fault.statusCode != globals.statusOk) {
        print('Error in getloggedInAthlete ${_athlete.fault.statusCode}');
      }

      // Type of expected answer 
      //  {"biggest_ride_distance":156733.0,"biggest_climb_elevation_gain":null,"recent_ride_totals":{"count":2,"distance":111427.7001953125,
      // "moving_time":17726,"elapsed_time":23181,"elevation_gain":1354.5838375091553,"achievement_count":0},"recent_run_to
      Stats _stats = await strava.getStats(_athlete.id);
      if (_stats.fault.statusCode != globals.statusOk) {
          print('Error in getloggedInAthlete ${_stats.fault.statusCode}');
      }
    
      // A long list of races per city
      // Starting by Walt Disney World Marathon
      List<RunningRace> listRunningRaces = await strava.getRunningRaces('2019');
      if ((listRunningRaces == null) || (listRunningRaces[0].fault.statusCode != globals.statusOk)) {
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
      if (_gear.fault.statusCode != globals. statusOk) {
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
      if (_activity.fault.statusCode != globals.statusOk) {
        print('Error in getActivityById: ${_activity.fault.statusCode}');

      }
    }
  }






  void upload() {
    print('Trying to upload');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    var fault = exampleUpload(secret);
  }

  void deAuthorize() async {
    // need to get authorized before (valid token)
    final strava = Strava(
      true,   // to get disply info in API
      secret, // Put your secret key in secret.dart file
    );
    var fault = await strava.deAuthorize();
  }

  @override
  void dispose() {
    strava.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(''),
            Text('Authentication'),
            Text('with segments Apis'),
            RaisedButton(
              child: Text('Segments'),
              // onPressed: exampleStrava,
              onPressed: exampleSeg,

            ),

            Text(''),
            Text('Authentication'),
            Text('with other Apis'),
            RaisedButton(
              child: Text('strava_flutter'),
              onPressed: exampleStrava,
            ),

            Text(''),
            Text(''),
            Text('Upload with authentication'),
            RaisedButton(
              child: Text('upload'),
              onPressed: upload,
            ),
            Text(' '),
            Text(''),
            Text(''),
            Text('Push this button'),
            Text(
              'to revoke/DeAuthorize Strava user',
            ),
            
            RaisedButton(
              child: Text('DeAuthorize'),
              onPressed: deAuthorize,
            ),
          ],
        ),
      ),
    );
  }
}
