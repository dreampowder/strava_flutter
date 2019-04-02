// athletes.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/stats.dart';
import '../Models/detailedAthlete.dart';
import '../Models/zone.dart';
import '../Models/activity.dart';
import '../Models/fault.dart';

import '../globals.dart' as globals;

abstract class Athletes {
  Future<DetailedAthlete> updateLoggedInAthlete(double weight) async {
    DetailedAthlete returnAthlete = DetailedAthlete();

    var _header = globals.createHeader();

    if (_header != null) {
      final reqAthlete =
          "https://www.strava.com/api/v3/athlete?weight=" + weight.toString();
      globals.displayInfo('update $reqAthlete');
      var rep = await http.put(reqAthlete, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo('Athlete info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
        globals
            .displayInfo(' athlete ${_athlete.firstname}, ${_athlete.weight}');

        returnAthlete = _athlete;
      } else {
        globals.displayInfo(
            'problem in updateLoggedInAthlete request , ${returnAthlete.fault.statusCode}  ${rep.body}');
      }

      returnAthlete.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }

    return returnAthlete;
  }

  /// For the moment, only 1 page is handled
  /// 50 activities max
  ///
  /// Give activiy stats of the loggedInAthlete
  ///
  Future<Stats> getStats(int id) async {
    Stats returnStats = Stats();

    var _header = globals.createHeader();

    if (_header != null) {
      final reqStats = "https://www.strava.com/api/v3/athletes/" +
          id.toString() +
          "/stats?page=1&per_page=50;";
      var rep = await http.get(reqStats, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo('getStats ${rep.body}');
      } else {
        globals.displayInfo('problem in getStats request, ${rep.statusCode}');
      }

      returnStats.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }
    return returnStats;
  }

  /// Provide zones heart rate or power for the logged athlete
  /// 
  /// scope needed: profile:read_all
  /// 
  /// 
  Future<Zone> getLoggedInAthleteZones() async {
    Zone returnZone = Zone();

    globals.displayInfo('Entering getLoggedInAthleteZones');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqAthlete = "https://www.strava.com/api/v3/athlete/zones";
      var rep = await http.get(reqAthlete, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo('Zone info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          Zone _zone = Zone();
          _zone = Zone.fromJson(jsonResponse);
          returnZone = _zone;
        }
      } else {
        globals.displayInfo(
            'problem in getLoggedInAthlete request ,   ${rep.body}');
      }
      returnZone.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }

    return returnZone;
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

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Athlete info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
        globals.displayInfo(
            ' athlete ${_athlete.firstname}, ${_athlete.lastname}');

        returnAthlete = _athlete;
      } else {
        globals.displayInfo(
            'problem in getLoggedInAthlete request , ${returnAthlete.fault.statusCode}  ${rep.body}');
      }

      returnAthlete.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }

    return returnAthlete;
  }




  ///
  /// scope needed: profile: activity:read_all 
  /// parameters:
  /// before: since time epoch in seconds
  /// after: since time epoch in seconsd
  ///
  /// return: a list of activities related to the logged athlete
  /// 
  /// Only the first 30 activities for the moment
  Future<List<SummaryActivity>> getLoggedInAthleteActivities(int before, int after) async {
    List<SummaryActivity> returnActivities = List<SummaryActivity>();

    var _header = globals.createHeader();

    if (_header != null) {
      final reqActivities = 
        "https://www.strava.com/api/v3/athlete/activities" +
        '?before=$before&after=$after&page1=&per_page=30';

      var rep = await http.get(reqActivities, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Activities info ${rep.body}');
        final jsonResponse = json.decode(rep.body);


        if (jsonResponse != null) {
          List<SummaryActivity> _listSummary = List<SummaryActivity>();

          jsonResponse.forEach((summ) {
            var activity = SummaryActivity.fromJson(summ);
            globals.displayInfo(
                '${activity.name} ,  ${activity.distance},  ${activity.id}');
            _listSummary.add(activity);
          });

        globals.displayInfo(_listSummary.toString());
        returnActivities = _listSummary;
      } else {
        globals.displayInfo(
            // 'problem in getLoggedInAthleteActivities , ${returnActivities[Ø].fault.statusCode}  ${rep.body}');
            'problem in getLoggedInAthleteActivities ,  ${rep.body}');
      }

      // returnActivities[0].fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }

    return returnActivities;
    }
  }





}
