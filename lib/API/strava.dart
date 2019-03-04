import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'token.dart';

import 'constants.dart';
import '../Models/gear.dart';
import '../Models/detailedAthlete.dart';
import '../Models/stats.dart';
import '../Models/club.dart';
import '../Models/detailedActivity.dart';
import '../Models/summaryActivity.dart';
import '../Models/zone.dart';
import '../Models/summaryAthlete.dart';
import '../Models/runningRace.dart';

import 'Oauth.dart';
import 'upload.dart';

/// Initialize the Strava API
///  clientID: ID of your Strava app
/// redirectURL: url that will be called after Strava authorize your app
/// prompt: to choose to ask Strava always to authenticate or only when needed (with 'auto')
/// scope: Strava scope check https://developers.strava.com/docs/oauth-updates/
class Strava with Upload, Auth {
  Strava( this.secret,  this.prompt);
  final String secret;
  final String prompt;


  final tokenEndpoint = "https://www.strava.com/oauth/token";
  final authorizationEndpoint = "https://www.strava.com/oauth/authorize";

  Map<String, String> header; // set in _getStoredToken


  /// getRunningRacebyId
  ///
  /// Scope needed:
  ///
  /// Answer has route_ids [int]
  Future<RunningRace> getRunningRaceById(String id) async {
    RunningRace returnRace = RunningRace();

    if (header != null) {
      final reqRace = 'https://www.strava.com/api/v3/running_races/' + id;

      var rep = await http.get(reqRace, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('Race info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          returnRace = RunningRace.fromJson(jsonResponse);
        } else {
          print('problem in getRunningRaceById request');
        }
      }
      return returnRace;
    }
  }

  // Scope needed:
  // Answer has NO route_ids
  Future<List<RunningRace>> getRunningRaces(String year) async {
    List<RunningRace> returnListRaces = List<RunningRace>();

    if (header != null) {
      final reqList =
          'https://www.strava.com/api/v3/running_races?year=' + year;

      var rep = await http.get(reqList, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('List races info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          List<RunningRace> _listRaces = List<RunningRace>();

          jsonResponse.forEach((element) {
            var race = RunningRace.fromJson(element);
            print('---> ${race.name} ,  ${race.startDateLocal}    ${race.id}');
            _listRaces.add(race);
          });

          returnListRaces = _listRaces;
        } else {
          print('problem in getRunningRaces request');
        }
      }
      return returnListRaces;
    }
  }

  // Scope needed:
  // id of the club
  Future<List<SummaryAthlete>> getClubMembersById(String id) async {
    List<SummaryAthlete> returnListMembers = List<SummaryAthlete>();

    if (header != null) {
      final reqList = "https://www.strava.com/api/v3/clubs/" +
          id +
          '/members?page=1&per_page=200';

      var rep = await http.get(reqList, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('List members info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          List<SummaryAthlete> _listMembers = List<SummaryAthlete>();

          jsonResponse.forEach((summ) {
            var member = SummaryAthlete.fromJson(summ);
            print(
                '---> ${member.lastname} ,  ${member.firstname},  admin:${member.admin}');
            _listMembers.add(member);
          });

          returnListMembers = _listMembers;
        } else {
          print('problem in getClubMembersById request');
        }
      }
    }
    return returnListMembers;
  }

  Future<DetailedActivity> getActivityById(String id) async {
    DetailedActivity returnActivity = DetailedActivity();

    if (header != null) {
      final reqActivity = "https://www.strava.com/api/v3/activities/" +
          id +
          '?include_all_efforts=true';
      var rep = await http.get(reqActivity, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('Activity info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        // Error 404  Activity not found

        DetailedActivity _activity = DetailedActivity.fromJson(jsonResponse);
        print(_activity.name);

        returnActivity = _activity;
      } else {
        print('problem in getActivityById request');
      }
    }
    return returnActivity;
  }

  Future<Club> getClubById(String id) async {
    Club returnClub;

    if (header != null) {
      final reqClub = 'https://www.strava.com/api/v3/clubs/' + id;
      var rep = await http.get(reqClub, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('Club info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        Club _club = Club.fromJson(jsonResponse);
        print(_club.name);

        returnClub = _club;
      } else {
        print('problem in getClubById request');
        // Todo add an error code
      }
    }
    return returnClub;
  }

  Future<List<SummaryActivity>> getClubActivitiesById(String id) async {
    List<SummaryActivity> returnSummary;

    if (header != null) {
      final reqClub = 'https://www.strava.com/api/v3/clubs/' +
          id +
          "/activities?page=1&per_page=10";
      var rep = await http.get(reqClub, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('Club activity ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          List<SummaryActivity> _listSummary = List<SummaryActivity>();

          jsonResponse.forEach((summ) {
            var activity = SummaryActivity.fromJson(summ);
            print(
                '---> ${activity.name} ,  ${activity.distance},  ${activity.id}');
            _listSummary.add(activity);
          });

          print(_listSummary);
          returnSummary = _listSummary;
        }
      } else {
        print('problem in getClubActivitiesById request');
        print('answer ${rep.body}');
      }
    }
    return returnSummary;
  }

  Future<Gear> getGearById(String id) async {
    Gear returnGear = Gear();

    if (header != null) {
      final reqGear = 'https://www.strava.com/api/v3/gear/' + id;
      var rep = await http.get(reqGear, headers: header);

      switch (rep.statusCode) {
        case 200:
          {
            print(rep.statusCode);
            print('Bike info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            Gear _gear = Gear.fromJson(jsonResponse);
            print(_gear.description);
            _gear.errorCode = ErrorCode.ok;
            returnGear = _gear;
          }
          break;

        case 401:
          {
            print('problem in getGearById request');
            returnGear.errorCode = ErrorCode.tokenIsInvalid;
          }
          break;

        default:
          {
            returnGear.errorCode = ErrorCode.unknownError;
          }
          break;
      }
    } else {
      returnGear.errorCode = ErrorCode.headerIsEmpty;
    }

    return returnGear;
  }

  Future<DetailedAthlete> getLoggedInAthlete() async {
    DetailedAthlete returnAthlete = DetailedAthlete();
    if (header != null) {
      final reqAthlete = "https://www.strava.com/api/v3/athlete";
      var rep = await http.get(reqAthlete, headers: header);

      switch (rep.statusCode) {
        case 200:
          {
            print(rep.statusCode);
            print('Athlete info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
            print(' athlete ${_athlete.firstname}, ${_athlete.lastname}');
            _athlete.errorCode = ErrorCode.ok;

            returnAthlete = _athlete;
          }
          break;

        case 401:
          {
            returnAthlete.errorCode = ErrorCode.tokenIsInvalid;

            print(
                'problem in getLoggedInAthlete request , ${returnAthlete.errorCode}  ${rep.body}');
          }
          break;

        default:
          {
            returnAthlete.errorCode = ErrorCode.unknownError;
            print('problem in getLoggedInAthlete, unknown error');
          }
          break;
      }
    }

    return returnAthlete;
  }

  Future<List<Zone>> getLoggedInAthleteZones() async {
    List<Zone> returnZones = List<Zone>();
    if (header != null) {
      final reqAthlete = "https://www.strava.com/api/v3/athlete/zones";
      var rep = await http.get(reqAthlete, headers: header);

      switch (rep.statusCode) {
        case 200:
          {
            print(rep.statusCode);
            print('Zone info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            if (jsonResponse != null) {
              List<Zone> _zones = List<Zone>();
              jsonResponse.forEach((value) {
                var zone = Zone.fromJson(value);
                print(zone.distributionBuckets);
                _zones.add(zone);
              });

              //  To fi
              // _zones.errorCode = ErrorCode.ok;

              returnZones = _zones;
            }
          }
          break;

        case 401:
          {
            // returnAthlete.errorCode = ErrorCode.tokenIsInvalid;

            print('problem in getLoggedInAthlete request ,   ${rep.body}');
          }
          break;

        default:
          {
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
    if (header != null) {
      // final reqAthlete = "https://www.strava.com/api/v3/athlete/&weight=" + weight.toString();
      final reqAthlete = 'https://www.strava.com/api/v3/athlete?weight=84.0';
      print('update $reqAthlete');
      var rep = await http.put(reqAthlete, headers: header);

      switch (rep.statusCode) {
        case 200:
          {
            print(rep.statusCode);
            print('Athlete info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
            print(' athlete ${_athlete.firstname}, ${_athlete.weight}');
            _athlete.errorCode = ErrorCode.ok;

            returnAthlete = _athlete;
          }
          break;

        case 401:
          {
            returnAthlete.errorCode = ErrorCode.tokenIsInvalid;

            print(
                'problem in updateLoggedInAthleteequest , ${returnAthlete.errorCode}  ${rep.body}');
          }
          break;

        default:
          {
            returnAthlete.errorCode = ErrorCode.unknownError;
            print(
                'problem in updateLoggedInAthlete, unknown error  ${rep.body}');
          }
          break;
      }
    }

    return returnAthlete;
  }

  Future<Stats> getStats(int id) async {
    Stats returnStats;
    if (header != null) {
      final reqStats = "https://www.strava.com/api/v3/athletes/" +
          id.toString() +
          "/stats?page=&per_page=;";
      var rep = await http.get(reqStats, headers: header);
      if (rep.statusCode == 200) {
        print(rep.statusCode);
        print('stats info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        Stats _stats = Stats.fromJson(jsonResponse);

        returnStats = _stats;
      } else {
        print('problem in getStats request');
        // Todo add an error code
      }
    }

    return returnStats;
  }

  void dispose() {
    onCodeReceived.close();
  }


}
