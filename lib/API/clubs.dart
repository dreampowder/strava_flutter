// clubs.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../Models/summaryAthlete.dart';
import '../Models/activity.dart';
import '../Models/club.dart';

import '../globals.dart' as globals;

abstract class Clubs {
  ///  Scope needed:
  /// id of the club
  /// No need to be member of the club
  Future<List<SummaryAthlete>> getClubMembersById(String id) async {
    List<SummaryAthlete> returnListMembers = List<SummaryAthlete>();

    globals.displayInfo('Entering getClubMembersById');

    var _header = globals.createHeader();

    if (_header != null) {
      final reqList = "https://www.strava.com/api/v3/clubs/" +
          id +
          '/members?page=1&per_page=200';

      var rep = await http.get(reqList, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('List members info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        if (jsonResponse != null) {
          List<SummaryAthlete> _listMembers = List<SummaryAthlete>();

          jsonResponse.forEach((summ) {
            var member = SummaryAthlete.fromJson(summ);
            globals.displayInfo(
                '${member.lastname} ,  ${member.firstname},  admin:${member.admin}');
            _listMembers.add(member);
          });

          returnListMembers = _listMembers;
        }
      } else {
        globals.displayInfo('Problem in getClubMembersById request');
      }

      returnListMembers[0].fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }
    return returnListMembers;
  }
  /// scope
  /// 
  Future<Club> getClubById(String id) async {
    Club returnClub;

    var _header = globals.createHeader();

    if (_header != null) {
      final reqClub = 'https://www.strava.com/api/v3/clubs/' + id;
      var rep = await http.get(reqClub, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Club info ${rep.body}');
        final jsonResponse = json.decode(rep.body);

        Club _club = Club.fromJson(jsonResponse);
        globals.displayInfo(_club.name);

        returnClub = _club;
      } else {
        globals.displayInfo('problem in getClubById request');
        // Todo add an error code
      }
      returnClub.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }

    return returnClub;
  }


  /// Need to be mmeber of the club
  /// 
  Future<List<SummaryActivity>> getClubActivitiesById(String id) async {
    List<SummaryActivity> returnSummary;

    var _header = globals.createHeader();

    if (_header != null) {
      final reqClub = 'https://www.strava.com/api/v3/clubs/' +
          id +
          "/activities?page=1&per_page=50";
      var rep = await http.get(reqClub, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        globals.displayInfo('Club activity ${rep.body}');
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
          returnSummary = _listSummary;
        }
      } else {
        globals.displayInfo('problem in getClubActivitiesById request');
        globals.displayInfo('answer ${rep.body}');
      }

      returnSummary[0].fault =
          globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    }
    return returnSummary;
  }
}
