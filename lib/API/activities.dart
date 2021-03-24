// activities.dart
import 'package:http/http.dart' as http;
import 'package:strava_flutter/Models/fault.dart';
import 'dart:convert';
import 'dart:async';

import '../globals.dart' as globals;
import '../errorCodes.dart' as error;

import '../Models/activity.dart';

abstract class Activities {
  /// scope: activity:read
  /// retrieve a detailed activity from its id
  ///
  Future<DetailedActivity> getActivityById(String id) async {
    DetailedActivity returnActivity = DetailedActivity();

    var _header = globals.createHeader();

    globals.displayInfo('Entering getActivityById');

    if (_header.containsKey('88') == false) {
      final String reqActivity = 'https://www.strava.com/api/v3/activities/' +
          id +
          '?include_all_efforts=true';
      var rep = await http.get(Uri.parse(reqActivity), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Activity info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);
        final DetailedActivity _activity =
            DetailedActivity.fromJson(jsonResponse);
        globals.displayInfo(_activity.name);

        returnActivity = _activity;
      } else {
        globals.displayInfo('Activity not found');
      }
      returnActivity.fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnActivity.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnActivity;
  }

  ///
  /// scope: activity:write
  ///
  /// Create a very simple activity
  ///
  /// NO photo can be added for the moment
  /// No check is done on parameters for the moment
  ///
  /// start date should be compliant to ISO 8601
  /// like 2019-02-18 10:02:13'
  ///
  Future<DetailedActivity> createActivity(
      String name, String type, String startDate, int elapsedTime,
      {String description, int distance, int isTrainer, int isCommute}) async {
    DetailedActivity returnActivity = DetailedActivity();

    var _header = globals.createHeader();

    globals.displayInfo('Entering createActivity');

    var _queryParams = {
      'name': name,
      'type': type,
      'start_date_local': startDate,
      'elapsed_time': (elapsedTime != null) ? elapsedTime.toString() : '0',
      'description': description ?? 'no description',
      'distance': (distance != null) ? distance.toString() : '0',
      'trainer': (isTrainer != null) ? isTrainer.toString() : '0',
      'commute': (isCommute != null) ? isCommute.toString() : '0',
    };

    if (_header.containsKey('88') == false) {
      var uri = Uri.https('www.strava.com', '/api/v3/activities', _queryParams);

      var resp = await http.post(uri, headers: _header);

      if (resp.statusCode == 201) {
        globals.displayInfo(resp.statusCode.toString());
        globals.displayInfo('Activity info ${resp.body}');
        final Map<String, dynamic> jsonResponse = json.decode(resp.body);

        final DetailedActivity _activity =
            DetailedActivity.fromJson(jsonResponse);
        globals.displayInfo(_activity.name);

        returnActivity = _activity;
      } else {
        globals.displayInfo('Activity not found');
      }
      returnActivity.fault =
          globals.errorCheck(resp.statusCode, resp.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnActivity.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnActivity;
  }

  ///
  /// scope: activity:write
  ///
  /// Get photos from an activity
  /// This is an undocumented unofficial API
  ///
  /// NOT WORKING yet
  ///
  Future<PhotoActivity> getPhotosFromActivityById(String id) async {
    var _header = globals.createHeader();

    var returnPhoto = PhotoActivity();

    globals.displayInfo('Entering getPhotosFromActivityById');

    if (_header.containsKey('88') == false) {
      final String reqActivity =
          'https://www.strava.com/api/v3/activities/' + id + '/photos';
      var rep = await http.get(Uri.parse(reqActivity), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Photos of activity${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);
        final DetailedActivity _activity =
            DetailedActivity.fromJson(jsonResponse);
        globals.displayInfo(_activity.name);

        // returnPhoto = _activity;
      } else {
        globals.displayInfo('Photo  not found');
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Photos of activity${rep.body}');
      }
      returnPhoto.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      // returnActivity.fault =
      // Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnPhoto;
  }
}
