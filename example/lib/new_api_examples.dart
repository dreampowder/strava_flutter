import 'package:example/main.dart';
import 'package:example/secret.dart';
import 'package:strava_flutter/models/strava_auth_scopes.dart';
import 'package:strava_flutter/models/strava_fault.dart';
import 'package:strava_flutter/strava_client.dart';

class NewApiExamples{
  static StravaClient client = StravaClient(secret, clientId);

  static void testAuthentication(){
    client.authenticate(
        scopes: [StravaAuthScope.profile_read_all, StravaAuthScope.read_all,StravaAuthScope.profile_write,StravaAuthScope.activity_read_all],
        redirectUrl: "stravaflutter://redirect/"
    ).catchError((error, stackTrace)=>print("Error authenticating: $error\n$stackTrace"))
      .then((value){
      print("Successfully authenticated strava");
      getClubActivities(898559);
    });
  }

  static void getLoggedInAthlete(){
    client.getLoggedInAthlete().then((athlete){
      print("Got response");
      print("Club ID: ${athlete.clubs.first}");
      print("Athlete: ${athlete.toJson()}");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }

  static void updateAthlete(double weight){
    client.updateLoggedInAthlete(weight).then((athlete){
      print("Got response");
      print("Updated Athlete: ${athlete.toJson()}");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }

  static void getStats(int athleteId){
    client.getStats(athleteId)
        .then((stats){
          print("Got Stats: ${stats.toJson()}");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }

  static void getZones(){
    client.getLoggedInAthleteZones()
        .then((zones){
          print("Got Zone: ${zones}");
    });
  }
  
  static void getLoggedInAthleteActivities(){
    client.getLoggedInAthleteActivities(1554209575, 1500)
        .then((activities){
          print("Activities: $activities");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }

  static void getClub(int clubId){
    client.getClubById(clubId)
        .then((club){
          print("Got Club: ${club.toJson()}");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }

  static void getClubActivities(int clubId){
    client.getClubActivitiesById(clubId)
        .then((value){
          print("Activities: $value");
    }).catchError((error,stackTrace){
      if(error is StravaFault){
        print("Error: ${error.toJson()}");
      }else{
        print("Unhandled error: $error");
        print("Stack: $stackTrace");
      }
    });
  }
}