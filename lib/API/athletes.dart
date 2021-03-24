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
import '../errorCodes.dart' as error;

abstract class Athletes {
  Future<DetailedAthlete> updateLoggedInAthlete(double weight) async {
    DetailedAthlete returnAthlete = DetailedAthlete();

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      final reqAthlete =
          "https://www.strava.com/api/v3/athlete?weight=" + weight.toString();
      globals.displayInfo('update $reqAthlete');
      var rep = await http.put(Uri.parse(reqAthlete), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo('Athlete info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

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

  ///
  ///
  /// Give activiy stats of the loggedInAthlete
  ///
  Future<Stats> getStats(int id) async {
    Stats returnStats = Stats();
    int _pageNumber = 1;
    int _perPage = 50;

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      final String reqStats = 'https://www.strava.com/api/v3/athletes/' +
          id.toString() +
          // "/stats?page=1&per_page=50;";
          '/stats?page=$_pageNumber&per_page=$_perPage;';

      var rep = await http.get(Uri.parse(reqStats), headers: _header);

      if (rep.statusCode == 200) {
        // globals.displayInfo('getStats ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          returnStats = Stats.fromJson(jsonResponse);

          globals.displayInfo(
              '${returnStats.ytdRideTotals.distance} ,  ${returnStats.recentRideTotals.elapsedTime}');
          returnStats.fault =
              globals.errorCheck(rep.statusCode, rep.reasonPhrase);
        } else {
          String msg = 'json answer is empty';
          returnStats.fault = globals.errorCheck(error.statusJsonIsEmpty, msg);
          globals.displayInfo(msg);
        }
      }
    } else {
      const String msg = 'problem in getStats request, header is empty';
      returnStats.fault = globals.errorCheck(error.statusTokenNotKnownYet, msg);
      globals.displayInfo(msg);
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

    if (_header.containsKey('88') == false) {
      const String reqAthlete = 'https://www.strava.com/api/v3/athlete/zones';
      var rep = await http.get(Uri.parse(reqAthlete), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo('Zone info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          Zone _zone = Zone();
          _zone = Zone.fromJson(jsonResponse);
          returnZone = _zone;
        }
      } else {
        globals.displayInfo(
            'problem in getLoggedInAthlete request ,   ${rep.body}');
      }
      returnZone.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
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

    if (_header.containsKey('88') == false) {
      const String reqAthlete = 'https://www.strava.com/api/v3/athlete';
      var rep = await http.get(Uri.parse(reqAthlete), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Athlete info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

        final DetailedAthlete _athlete = DetailedAthlete.fromJson(jsonResponse);
        globals.displayInfo(
            ' athlete ${_athlete.firstname}, ${_athlete.lastname}');

        returnAthlete = _athlete;
      } else {
        globals.displayInfo(
            'problem in getLoggedInAthlete request , ${returnAthlete.fault.statusCode}  ${rep.body}');
      }

      returnAthlete.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnAthlete.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
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
  ///  null if the authentication has not been done before
  ///
  Future<List<SummaryActivity>> getLoggedInAthleteActivities(
      int before, int after) async {
    List<SummaryActivity> returnActivities = List<SummaryActivity>();

    var _header = globals.createHeader();
    int _pageNumber = 1;
    int _perPage = 20; // Number of activities retrieved per http request
    bool isRetrieveDone = false;
    List<SummaryActivity> _listSummary = List<SummaryActivity>();

    globals.displayInfo('Entering getLoggedInAthleteActivities');

    if (_header.containsKey('88') == false) {
      do {
        final String reqActivities =
            'https://www.strava.com/api/v3/athlete/activities' +
                '?before=$before&after=$after&page=$_pageNumber&per_page=$_perPage';

        var rep = await http.get(Uri.parse(reqActivities), headers: _header);
        int _nbActvity = 0;

        if (rep.statusCode == 200) {
          globals.displayInfo(rep.statusCode.toString());
          globals.displayInfo('Activities info ${rep.body}');
          // final Map<String, dynamic> jsonResponse = json.decode(rep.body);
          var jsonResponse = json.decode(rep.body);

          if (jsonResponse != null) {
            jsonResponse.forEach((summ) {
              var activity = SummaryActivity.fromJson(summ);
              globals.displayInfo(
                  '${activity.name} ,  ${activity.distance},  ${activity.id}');
              _listSummary.add(activity);
              _nbActvity++;
            });

            // Check if it is the last page
            globals.displayInfo(_nbActvity.toString());
            if (_nbActvity < _perPage) {
              isRetrieveDone = true;
            } else {
              // Move to the next page
              _pageNumber++;
            }

            globals.displayInfo(_listSummary.toString());
            returnActivities = _listSummary;
          } else {
            globals.displayInfo(
                // 'problem in getLoggedInAthleteActivities , ${returnActivities[Ø].fault.statusCode}  ${rep.body}');
                'problem in getLoggedInAthleteActivities ,  ${rep.body}');
          }

          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
        } else {
          // Answer is not correct
          globals.displayInfo('return code is NOT 200');
          globals.displayInfo(rep.statusCode.toString());
          return null;
        }
      } while (!isRetrieveDone);
    } else {
      globals.displayInfo('Token not yet known');
      return null;
    }

    return returnActivities;
  }
}
