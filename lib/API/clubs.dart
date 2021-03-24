// clubs.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/summaryAthlete.dart';
import '../Models/activity.dart';
import '../Models/club.dart';
import '../Models/fault.dart';

import '../globals.dart' as globals;
import '../errorCodes.dart' as error;

abstract class Clubs {
  ///  Scope needed:
  /// id of the club
  /// No need to be member of the club
  Future<List<SummaryAthlete>> getClubMembersById(String id) async {
    List<SummaryAthlete> returnListMembers = List<SummaryAthlete>();
    int _pageNumber = 1;
    int _perPage = 30; // Number of activities retrieved per http request
    bool isRetrieveDone = false;
    List<SummaryAthlete> _listSummary = List<SummaryAthlete>();

    globals.displayInfo('Entering getClubMembersById');

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      do {
        String reqList = "https://www.strava.com/api/v3/clubs/" +
            id +
            '/members?page=$_pageNumber&per_page=$_perPage';

        var rep = await http.get(Uri.parse(reqList), headers: _header);
        int _nbMembers = 0;

        if (rep.statusCode == 200) {
          globals.displayInfo(rep.statusCode.toString());
          globals.displayInfo('List members info ${rep.body}');
          var jsonResponse = json.decode(rep.body);

          if (jsonResponse != null) {
            jsonResponse.forEach((summ) {
              var member = SummaryAthlete.fromJson(summ);
              globals.displayInfo(
                  '${member.lastname} ,  ${member.firstname},  admin:${member.admin}');
              _listSummary.add(member);
              _nbMembers++;
            });

            // Check if it is the last page
            globals.displayInfo(_nbMembers.toString());
            if (_nbMembers < _perPage) {
              isRetrieveDone = true;
            } else {
              // Move to the next page
              _pageNumber++;
            }

            globals.displayInfo(_listSummary.toString());
            returnListMembers = _listSummary;
          }
        } else {
          globals.displayInfo('Problem in getClubMembersById request');
        }

        returnListMembers[0].fault =
            globals.errorCheck(rep.statusCode, rep.reasonPhrase);
      } while (!isRetrieveDone);
    } else {
      globals.displayInfo('Token not yet known');
      returnListMembers[0].fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnListMembers;
  }

  /// scope
  ///
  Future<Club> getClubById(String id) async {
    Club returnClub;

    var _header = globals.createHeader();

    if (_header.containsKey('88') == false) {
      final reqClub = 'https://www.strava.com/api/v3/clubs/' + id;
      var rep = await http.get(Uri.parse(reqClub), headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Club info ${rep.body}');
        final Map<String, dynamic> jsonResponse = json.decode(rep.body);

        Club _club = Club.fromJson(jsonResponse);
        globals.displayInfo(_club.name);

        returnClub = _club;
      } else {
        globals.displayInfo('problem in getClubById request');
        // Todo add an error code
      }
      returnClub.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    } else {
      globals.displayInfo('Token not yet known');
      returnClub.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnClub;
  }

  /// Need to be member of the club
  ///
  Future<List<SummaryActivity>> getClubActivitiesById(String id) async {
    List<SummaryActivity> returnSummary = <SummaryActivity>[];

    var _header = globals.createHeader();
    int _pageNumber = 1;
    int _perPage = 20; // Number of activities retrieved per http request
    bool isRetrieveDone = false;
    List<SummaryActivity> _listSummary = List<SummaryActivity>();

    if (_header.containsKey('88') == false) {
      do {
        String reqClub = 'https://www.strava.com/api/v3/clubs/' +
            id +
            '/activities?page=$_pageNumber&per_page=$_perPage';
        var rep = await http.get(Uri.parse(reqClub), headers: _header);
        int _nbActvity = 0;

        if (rep.statusCode == 200) {
          globals.displayInfo(rep.statusCode.toString());
          // globals.displayInfo('Club activity ${rep.body}');
          var jsonResponse = json.decode(rep.body);

          if (jsonResponse != null) {
            jsonResponse.forEach((summ) {
              var activity = SummaryActivity.fromJson(summ);
              globals.displayInfo(
                  '------ ${activity.name} ,  ${activity.distance},  ${activity.id}');
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
            returnSummary = _listSummary;
          }
        } else {
          globals.displayInfo('problem in getClubActivitiesById request');
          globals.displayInfo('answer ${rep.body}');
          returnSummary[0].fault =
              globals.errorCheck(rep.statusCode, rep.reasonPhrase);
        }

        returnSummary[0].fault =
            globals.errorCheck(rep.statusCode, rep.reasonPhrase);
      } while (!isRetrieveDone);
    } else {
      globals.displayInfo('Token not yet known');
      returnSummary[0].fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }

    return returnSummary;
  }
}
