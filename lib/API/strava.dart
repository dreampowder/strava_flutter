import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'token.dart';

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

import 'upload.dart';

/// Initialize the Strava API
///  clientID: ID of your Strava app
/// redirectURL: url that will be called after Strava authorize your app
/// prompt: to choose to ask Strava always to authenticate or only when needed (with 'auto')
/// scope: Strava scope check https://developers.strava.com/docs/oauth-updates/
class Strava with Upload {
  Strava(this.clientID, this.secret, this.redirectUrl, this.prompt, this.scope);
  final String clientID;
  final String secret;
  final String redirectUrl;
  final String prompt;
  final String scope;

  final tokenEndpoint = "https://www.strava.com/oauth/token";
  final authorizationEndpoint = "https://www.strava.com/oauth/authorize";

  Map<String, String> header; // set in _getStoredToken

  StreamController<String> onCodeReceived = StreamController();

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

//===========================================
// Code related to Authorization processs
//===========================================

// Save the token and the expiry date
  void _saveToken(String token, int expire) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('expire', expire); // Stored in seconds

    print('token saved!!!');
  }

// get the stored token and expiry date
  Future<Token> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    var localToken = Token();
    try {
      localToken.accessToken = prefs.getString('token').toString();
      localToken.expiresAt = prefs.getInt('expire');

      // Update the header
      // header is global to change TODO:
      header = {'Authorization': 'Bearer ${localToken.accessToken}'};
    } catch (error) {
      print('Error getting the key');
      localToken.accessToken = null;
      localToken.expiresAt = null;
    }

    if (localToken.expiresAt != null) {
      var dateExpired =
          DateTime.fromMillisecondsSinceEpoch(localToken.expiresAt);
      var disp = dateExpired.day.toString() +
          dateExpired.month.toString() +
          dateExpired.hour.toString();
      print('stored token ${localToken.accessToken}  expires: $disp ');
    }

    return (localToken);
  }

// Get the code from Strava
// TODO: Test when no internet and when error url

  Future<void> _getStravaCode(
      String clientID, String redirectUrl, String scope) async {
    print('Welcome to getStravaCode');
    var code = "";
    var params = '?' +
        'client_id=' +
        clientID +
        '&redirect_uri=' +
        redirectUrl +
        '&response_type=' +
        'code' +
        '&approval_prompt=' +
        'auto' +
        // '&scope=' + 'read,read_all,profile:read_all';
        '&scope=' +
        scope;

    var reqAuth = authorizationEndpoint + params;
    print('---> $reqAuth');

    closeWebView();
    launch(reqAuth,
        forceWebView: true, forceSafariVC: true, enableJavaScript: true);

    // Launch small http server to collect the answer from Strava
    //------------------------------------------------------------
    final server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
    server.listen((HttpRequest request) async {
      // Get the answer from Strava
      final uri = request.uri;

      code = uri.queryParameters["code"];
      final error = uri.queryParameters["error"];
      print('---> code $code, error $error');

      closeWebView();
      server.close(force: true);

      onCodeReceived.add(code);
    });

    print('End of getStravaCode');
  }

  Future<Token> _getStravaToken(String code) async {
    Token _answer = Token();

    print('---> Entering getStravaToken!!');
    var urlToken = tokenEndpoint +
        '?client_id=' +
        clientID +
        '&client_secret=' +
        secret + // Put your own secret in secret.dart
        '&code=' +
        code +
        '&grant_type=' +
        'authorization_code';

    print('----> urlToken $urlToken');

    var value = await http.post(urlToken);

    // responseToken.then((value) {
    print('----> body ${value.body}');

    if (value.body.contains('message')) {
      // This is not the normal message
      print('---> Error in getStravaToken');
      // will return _answer null
    } else {
      var tokenBody = json.decode(value.body);
      // Todo: handle error with message "Authorization Error" and errors != null
      var _body = Token.fromJson(tokenBody);
      var accessToken = _body.accessToken;
      var refreshToken = _body.refreshToken;
      var expiresAt = _body.expiresAt * 1000;

      _answer.accessToken = accessToken;
      _answer.refreshToken = refreshToken;
      _answer.expiresAt = expiresAt;
    }
    
    return (_answer);
    // });
  }

  bool _isTokenExpired(Token token) {
    final DateTime _expiryDate =
        DateTime.fromMillisecondsSinceEpoch(token.expiresAt);
    return (_expiryDate.isBefore(DateTime.now()));
  }

  Future<bool> Auth() async {
    bool isExpired = true;
    bool returnValue = false;

    final Token tokenStored = await getStoredToken();
    final String _token = tokenStored.accessToken;

    // Check if the token is not expired
    if (_token != "null") {
      print('----> token has been stored before! ${tokenStored.accessToken}');

      isExpired = _isTokenExpired(tokenStored);
    }

    // Check if access token has been stored previously or expired
    if ((_token == "null") || (isExpired)) {
      await _getStravaCode(clientID, redirectUrl, scope);

      onCodeReceived.stream.listen((stravaCode) async {
        if (stravaCode != null) {
          var answer = await _getStravaToken(stravaCode);

          print('---> answer ${answer.expiresAt}  , ${answer.accessToken}');

          // Save the token information
          if (answer.accessToken != null && answer.expiresAt != null) {
               _saveToken(answer.accessToken, answer.expiresAt);
          }
       
          // Update the header
          header = {'----> Authorization': 'Bearer ${answer.accessToken}'};
          returnValue = true;
        } else {
          print('----> code is still null');
          returnValue = false;
        }
      });
    } else {
      // No need to start again the authentication
      // Use directly the stored token
      // Update the header
      header = {'Authorization': 'Bearer $_token'};
      returnValue = true;
    }

    return (returnValue);
  }

  Future<void> deAuthorize() async {
    String returnValue;

    var _token = await getStoredToken();

    header = {'Authorization': 'Bearer ${_token.accessToken}'};

    if (header != null) {
      final reqDeAuthorize = "https://www.strava.com/oauth/deauthorize";
      var rep = await http.post(reqDeAuthorize, headers: header);
      if (rep.statusCode == 200) {
        print('DeAuthorize done');
        _saveToken(null, null);
      } else {
        print('problem in deAuthorize request');
        // Todo add an error code
      }
    }
  }
}
