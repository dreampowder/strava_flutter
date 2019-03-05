import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import '../Models/fault.dart';
import '../Models/gear.dart';
import '../Models/detailedAthlete.dart';
import '../Models/stats.dart';
import '../Models/detailedActivity.dart';
import '../Models/zone.dart';
import '../Models/runningRace.dart';

import 'globals.dart' as globals;
import 'Oauth.dart';
import 'upload.dart';
import 'clubs.dart';


/// Initialize the Strava API
///  clientID: ID of your Strava app
/// redirectURL: url that will be called after Strava authorize your app
/// prompt: to choose to ask Strava always to authenticate or only when needed (with 'auto')
/// scope: Strava scope check https://developers.strava.com/docs/oauth-updates/
class Strava with Upload, Auth, Clubs {
  String secret;
 
  Strava (bool isInDebug, String secretKey) {
    globals.isInDebug = isInDebug;
    secret = secretKey;
  }

  // Strava( this.isInDebug, this.secret);
  // final bool isInDebug;
  // final String secret;
  

/// List of statuscode used by Fault 
/// To get info to API caller
/// Should have a nicer to do it in Dart!
final statusOk = 0;
final statusInvalidToken = 1;
final statusUnknownError = 2;
final statusHeaderIsEmpty = 3;
final statusNotFound = 4;




  /// getRunningRacebyId
  ///
  /// Scope needed: none
  ///
  /// Answer has route_ids [int]
  Future<RunningRace> getRunningRaceById(String id) async {
    RunningRace returnRace = RunningRace();

    globals.displayInfo('Entering getRunningRaceById');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqRace = 'https://www.strava.com/api/v3/running_races/' + id;

      var rep = await http.get(reqRace, headers: _header);
      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Race info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          returnRace = RunningRace.fromJson(jsonResponse);
        } else {
          globals.displayInfo('problem in getRunningRaceById request');
        }
      }
      return returnRace;
    }
  }

  /// Scope needed: none
  /// Answer has NO route_ids for the moment
  Future<List<RunningRace>> getRunningRaces(String year) async {
    List<RunningRace> returnListRaces = List<RunningRace>();

    globals.displayInfo('Entering getRunningRaces');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqList =
          'https://www.strava.com/api/v3/running_races?year=' + year;

      var rep = await http.get(reqList, headers: _header);
      if (rep.statusCode == 200) {
        // globals.displayInfo('List races info ${rep.body}');
        final jsonResponse = json.decode(rep.body);
      

        if (jsonResponse != null) {
          List<RunningRace> _listRaces = List<RunningRace>();

          jsonResponse.forEach((element) {
            var _race = RunningRace.fromJson(element);
            _race.fault = Fault(88, '');
            globals.displayInfo('${_race.name} ,  ${_race.startDateLocal}    ${_race.id}');
            _race.fault.statusCode = statusOk;
            _listRaces.add(_race);
          });

          returnListRaces = _listRaces;
        } else {
          globals.displayInfo('problem in getRunningRaces request');
        }
      }
      return returnListRaces;
    }
  }

  
  /// scope: activity:read
  Future<DetailedActivity> getActivityById(String id) async {
    DetailedActivity returnActivity = DetailedActivity();

    var _header = globals.createHeader();

    globals.displayInfo('Entering getActivityById');

    if (_header != null) {
      final reqActivity = "https://www.strava.com/api/v3/activities/" +
          id +  '?include_all_efforts=true';
      var rep = await http.get(reqActivity, headers: _header);

  switch (rep.statusCode) {
      case 200: {

        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Activity info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        

        DetailedActivity _activity = DetailedActivity.fromJson(jsonResponse);
        _activity.fault = Fault(88, '');
        _activity.fault.statusCode = statusOk;
        globals.displayInfo(_activity.name);

        returnActivity = _activity;
        break;
      }

      case 404: {
        globals.displayInfo('Activity not found');
        returnActivity.fault.statusCode = statusNotFound;
      }
      break;
      
      default: {
        returnActivity.fault.statusCode = statusUnknownError;

        break;
      }

      // add error 404 activity not found

    }
    return returnActivity;
  }
  }

  

  

  /// Scope needed: any
  /// Give answer only if id is related to logged athlete
  /// 
  Future<Gear> getGearById(String id) async {
    Gear returnGear = Gear();

    globals.displayInfo('Entering getGearById');

    var _header = globals.createHeader();


    if (_header != null) {
      final reqGear = 'https://www.strava.com/api/v3/gear/' + id;
      var rep = await http.get(reqGear, headers: _header);

      switch (rep.statusCode) {
        case 200: {
            globals.displayInfo(rep.statusCode.toString());
            globals.displayInfo(' ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            Gear _gear = Gear.fromJson(jsonResponse);
            _gear.fault = Fault(88, '');
            globals.displayInfo(_gear.description);
            _gear.fault.statusCode = statusOk;
            returnGear = _gear;
        }
        break;

        case 401: { 
            returnGear.fault.statusCode = statusInvalidToken;
        }
        break;

        default: {
            returnGear.fault.statusCode = statusUnknownError;
        }
        break;
      }
    } else {
      returnGear.fault.statusCode = statusHeaderIsEmpty;
    }

    return returnGear;
  }

  /// 
  /// scope needed: profile:read_all scope
  /// 
  /// return: see status value in strava class
  Future<DetailedAthlete> getLoggedInAthlete() async {
    DetailedAthlete returnAthlete = DetailedAthlete();
    returnAthlete.fault = Fault(88, '');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqAthlete = "https://www.strava.com/api/v3/athlete";
      var rep = await http.get(reqAthlete, headers: _header);

      switch (rep.statusCode) {
        case 200: {
            globals.displayInfo(rep.statusCode.toString());
            globals.displayInfo('Athlete info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
            globals.displayInfo(' athlete ${_athlete.firstname}, ${_athlete.lastname}');
            _athlete.fault = Fault(statusOk, 'getLoggedInAthlete done');

            returnAthlete = _athlete;
        }
        break;

        case 401:{
            returnAthlete.fault = Fault(statusInvalidToken, 'invalid token');

            globals.displayInfo(
                'problem in getLoggedInAthlete request , ${returnAthlete.fault.statusCode}  ${rep.body}');
        }
      break;

        default: {
            returnAthlete.fault = Fault(statusUnknownError, 'Unknown Error');
            globals.displayInfo('problem in getLoggedInAthlete, unknown error');
        }
        break;
      }
    }

    return returnAthlete;
  }

  Future<List<Zone>> getLoggedInAthleteZones() async {
    List<Zone> returnZones = List<Zone>();

    globals.displayInfo('Entering getLoggedInAthleteZones');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqAthlete = "https://www.strava.com/api/v3/athlete/zones";
      var rep = await http.get(reqAthlete, headers: _header);

      switch (rep.statusCode) {
        case 200: {
            globals.displayInfo(rep.statusCode.toString());
            globals.displayInfo('Zone info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            if (jsonResponse != null) {
              List<Zone> _zones = List<Zone>();
              jsonResponse.forEach((value) {
                var zone = Zone.fromJson(value);
                print(zone.distributionBuckets);
                _zones.add(zone);
              });

              ;

              returnZones = _zones;
            }
          }
          break;

        case 401: {
            // returnAthlete.errorCode = ErrorCode.tokenIsInvalid;

            print('problem in getLoggedInAthlete request ,   ${rep.body}');
        }
        break;

        default:{
            // returnAthlete.errorCode = ErrorCode.unknownError;
            print('problem in getLoggedInAthlete, unknown error');
        }
        break;
      }
    }

    return returnZones;
  }

  Future<DetailedAthlete> updateLoggedInAthlete(double weight) async {
    DetailedAthlete returnAthlete = DetailedAthlete();

    var _header = globals.createHeader();

    if (_header != null) {
      // final reqAthlete = "https://www.strava.com/api/v3/athlete/&weight=" + weight.toString();
      final reqAthlete = 'https://www.strava.com/api/v3/athlete?weight=84.0';
      print('update $reqAthlete');
      var rep = await http.put(reqAthlete, headers: _header);

      switch (rep.statusCode) {
        case 200:{
            globals.displayInfo(rep.statusCode.toString());
            globals.displayInfo('Athlete info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
            print(' athlete ${_athlete.firstname}, ${_athlete.weight}');
            _athlete.fault.statusCode = statusOk;

            returnAthlete = _athlete;
        }
        break;

        case 401: {
            returnAthlete.fault.statusCode = statusInvalidToken;

            globals.displayInfo(
                'problem in updateLoggedInAthleteequest , ${returnAthlete.fault.statusCode}  ${rep.body}');
        }
        break;

        default: {
            returnAthlete.fault.statusCode = statusUnknownError;
            globals.displayInfo(
                'problem in updateLoggedInAthlete, unknown error  ${rep.body}');
        }
        break;
      }
    }

    return returnAthlete;
  }

  /// For the moment, only 1 page is handled
  /// 
  Future<Stats> getStats(int id) async {
    Stats returnStats;

    var _header = globals.createHeader();

    if (_header != null) {
      final reqStats = "https://www.strava.com/api/v3/athletes/" +
          id.toString() +
          "/stats?page=&per_page=;";
      var rep = await http.get(reqStats, headers: _header);

    switch (rep.statusCode) {
      case 200: { 
        globals.displayInfo('stats info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        Stats _stats = Stats.fromJson(jsonResponse);
        _stats.fault =Fault(88, '');
        _stats.fault.statusCode = statusOk;
        returnStats = _stats;
      } 
      break;
      
      // case 400:
      
      default: {
        returnStats.fault.statusCode = statusUnknownError;
        globals.displayInfo('problem in getStats request, {rep.statusCode}');
      }
      break;
    }

    return returnStats;
  }
}

  void dispose() {
    onCodeReceived.close();
  }
}
