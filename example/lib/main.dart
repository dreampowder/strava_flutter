import 'package:flutter/material.dart';

import 'secret.dart'; // Store Strava app secret

import 'package:strava_flutter/API/strava.dart';
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

  String clientID = "32212";
  final String redirectUrl = "http://localhost:8080";
  final String scope = 'profile:write';

  final strava = Strava(
            "32212",    // Put your Strava id app
            secret,     // Put your secret key in secret.dart file
            "http://localhost:8080", 
            'auto',
            'profile:write',   // The scope you need 
            // Check https://developers.strava.com/docs/oauth-updates/  scope update
          );

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  void example() async {
    var resAuth = await strava.OAuth(clientID, redirectUrl, scope, secret);

    if (resAuth) {
      DetailedAthlete athlete = await strava.getLoggedInAthlete();

      List<RunningRace> listRunningRaces = await strava.getRunningRaces("2019");

      RunningRace race = await strava.getRunningRaceById('2724');

      // Not working yet
      DetailedAthlete athlete2 = await strava.updateLoggedInAthlete(84);

      Gear gear = await strava.getGearById("b4366285");
      // print('error code getGearById  ${gear.errorCode}');

      Stats stats = await strava.getStats(athlete.id);

      // List<Zone> list = await strava.getLoggedInAthleteZones();

      final clubStravaMarseille = '226910';  // You have to join this club to to the test

      Club club = await strava.getClubById(clubStravaMarseille);

      // Test getActivityById
      DetailedActivity _activity = await strava.getActivityById('2131889191');

      List<SummaryAthlete> listMembers = await strava.getClubMembersById('1');

      List<SummaryActivity> listSumm =
          await strava.getClubActivitiesById(clubStravaMarseille);
    }
  }


  void upload() {
    print('Trying to upload');

    showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator(),);
                  });

    // var upload = Upload();

    // upload.test1();

    strava.test2(secret);


  }

  void deAuthorize() async {
    // need to get authorized before (valid token)
    await strava.deAuthorize();
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Working 
            // Image.asset('assets/test.JPG'),
            
            Text('Push this button'),
            Text(
              'to revoke/DeAuthorize Strava user',
            ),
            Text(''),
            RaisedButton(
              child: Text('DeAuthorize'),
              onPressed: deAuthorize,
            ),
            Text('Push this button to start'),
            Text(
              'the Strava authentication',
            ),
            Text(
              'using basic example',
            ),
            Text(''),
            Text('Authentication'),
            Text('with strava_flutter Api'),
            RaisedButton(
              child: Text('strava_flutter'),
              onPressed: example,
            ),
            Text(''),
            Text('Upload with authentication'),
            RaisedButton(
              child: Text('upload'),
              onPressed: upload,
            ),
          ],
        ),
      ),
    );
  }
}
