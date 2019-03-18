// activities.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'globals.dart' as globals;

import 'package:strava_flutter/Models/detailedActivity.dart';
import 'package:strava_flutter/Models/fault.dart';

abstract class Activities {
  /// scope: activity:read
  /// retrieve a detailed activity from its id
  ///
  Future<DetailedActivity> getActivityById(String id) async {
    DetailedActivity returnActivity = DetailedActivity();

    var _header = globals.createHeader();

    globals.displayInfo('Entering getActivityById');

    if (_header != null) {
      final reqActivity = "https://www.strava.com/api/v3/activities/" +
          id +
          '?include_all_efforts=true';
      var rep = await http.get(reqActivity, headers: _header);

      switch (rep.statusCode) {
        case 200:
          {
            globals.displayInfo(rep.statusCode.toString());
            globals.displayInfo('Activity info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedActivity _activity =
                DetailedActivity.fromJson(jsonResponse);
            _activity.fault = Fault(88, '');
            _activity.fault.statusCode = globals.statusOk;
            globals.displayInfo(_activity.name);

            returnActivity = _activity;
            break;
          }

        case 404:
          {
            globals.displayInfo('Activity not found');
            returnActivity.fault.statusCode = globals.statusNotFound;
          }
          break;

        default:
          {
            returnActivity.fault.statusCode = globals.statusUnknownError;

            break;
          }
      }
    }
    return returnActivity;
  }

  /// NOT WORKING YET
  /// scope: activity:write
  /// Retrieve a detailed activity from its id
  /// NO photo can be added for the moment
  /// No check is done on parameters for the moment
  /// start date should be compliant to ISO 8601
  Future<DetailedActivity> createActivity(
      String name,
      String type,
      String startDate,
      int elapsedTime,
      {
        String description,
        int distance,
        int isTrainer,
        int isCommute
      } 
    ) async {
    DetailedActivity returnActivity = DetailedActivity();

    var _header = globals.createHeader();

    globals.displayInfo('Entering createActivity');

    if (_header != null) {

      /*****
      final reqActivity = "https://www.strava.com/api/v3/activities/" +
          '?name=' + name +
          '&type=' + type +
          '&start_date_local=' + startDate +
          '&elapsed_time=' + elapsedTime.toString()
          
          ;
   *****/
   final reqActivity = Uri.parse('https://www.strava.com/api/v3/activities/');

  var request = http.MultipartRequest("POST", reqActivity);
    request.fields['name'] = name; // tested with gpx
    request.fields['type'] = type;
    request.fields['start_date_local'] = startDate;
    request.fields['elapsed_time='] = elapsedTime.toString();

    request.headers.addAll(globals.createHeader());




      var rep = await request.send();
      // var rep = await http.post(reqActivity, headers: _header);

      switch (rep.statusCode) {
        case 201:
          {
            globals.displayInfo(rep.statusCode.toString());
            /***
            globals.displayInfo('Activity info ${rep.body}');
            final jsonResponse = json.decode(rep.body);

            DetailedActivity _activity =
                DetailedActivity.fromJson(jsonResponse);
            _activity.fault = Fault(88, '');
            _activity.fault.statusCode = globals.statusOk;
            globals.displayInfo(_activity.name);

            returnActivity = _activity;
*****/
            break;
          }

        case 404:
          {
            globals.displayInfo('Activity not found');
            returnActivity.fault.statusCode = globals.statusNotFound;
          }
          break;

        default:
          {
            returnActivity.fault.statusCode = globals.statusUnknownError;

            break;
          }
      }
    }
    return returnActivity;
  }
}
