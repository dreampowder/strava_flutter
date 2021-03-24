// races.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/runningRace.dart';
import '../Models/fault.dart';

import '../globals.dart' as globals;
import '../errorCodes.dart' as error;

abstract class Races {
  /// getRunningRacebyId
  ///
  /// Scope needed: none
  ///
  /// Answer has route_ids [int]
  Future<RunningRace> getRunningRaceById(String id) async {
    RunningRace returnRace = RunningRace();

    globals.displayInfo('Entering getRunningRaceById');

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      final reqRace = 'https://www.strava.com/api/v3/running_races/' + id;

      var rep = await http.get(Uri.parse(reqRace), headers: _header);
      if (rep.statusCode == 200) {
        globals.displayInfo('Race info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          returnRace = RunningRace.fromJson(jsonResponse);
        } else {
          globals.displayInfo('problem in getRunningRaceById request');
        }
      }
      returnRace.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnRace.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnRace;
  }

  /// Scope needed: none
  /// Answer has NO route_ids for the moment
  Future<List<RunningRace>> getRunningRaces(String year) async {
    List<RunningRace> returnListRaces = List<RunningRace>();

    globals.displayInfo('Entering getRunningRaces');

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      final reqList =
          'https://www.strava.com/api/v3/running_races?year=' + year;

      var rep = await http.get(Uri.parse(reqList), headers: _header);
      if (rep.statusCode == 200) {
        // globals.displayInfo('List races info ${rep.body}');
        var jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          List<RunningRace> _listRaces = List<RunningRace>();

          jsonResponse.forEach((element) {
            var _race = RunningRace.fromJson(element);
            globals.displayInfo(
                '${_race.name} ,  ${_race.startDateLocal}    ${_race.id}');
            _listRaces.add(_race);
          });

          returnListRaces = _listRaces;
        } else {
          globals.displayInfo('problem in getRunningRaces request');
        }
      }
      returnListRaces[0].fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnListRaces[0].fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }
    return returnListRaces;
  }
}
