import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'Models/fault.dart';
import 'Models/gear.dart';

import 'globals.dart' as globals;
import 'error_codes.dart' as error;

import 'api/strava_api.dart';

/// Initialize the Strava API
///  clientID: ID of your Strava app
/// redirectURL: url that will be called after Strava authorize your app
/// prompt: to choose to ask Strava always to authenticate or only when needed (with 'auto')
/// scope: Strava scope check https://developers.strava.com/docs/oauth-updates/
class Strava
    with
        Upload,
        Activities,
        Auth,
        ClubsRepository,
        Segments,
        SegmentEfforts,
        AthletesRepository,
        Races {
  String? secret;

  /// Initialize the Strava class
  /// Needed to call Strava API
  ///
  /// secretKey is the key found in strava settings my Application (secret key)
  /// Set isIndebug to true to get debug print in strava API
  Strava(bool isInDebug, String? secretKey) {
    globals.isInDebug = isInDebug;
    secret = secretKey;
  }

  /// Scope needed: any
  /// Give answer only if id is related to logged athlete
  ///
  Future<Gear> getGearById(String? id) async {
    throw UnimplementedError();
    // Gear returnGear = Gear();
    //
    // globals.displayInfo('Entering getGearById');
    //
    // final _header = globals.createHeader();
    //
    // if (_header.containsKey('88') == false) {
    //   final reqGear = 'https://www.strava.com/api/v3/gear/$id';
    //   final rep = await http.get(Uri.parse(reqGear), headers: _header);
    //
    //   if (rep.statusCode == 200) {
    //     globals.displayInfo(rep.statusCode.toString());
    //     globals.displayInfo(' ${rep.body}');
    //     final Map<String, dynamic> jsonResponse = json.decode(rep.body);
    //
    //     Gear _gear = Gear.fromJson(jsonResponse);
    //     _gear.fault = Fault(88, '');
    //     globals.displayInfo(_gear.description);
    //     _gear.fault.statusCode = error.statusOk;
    //     returnGear = _gear;
    //   } else {
    //     globals.displayInfo('Problem in getGearById');
    //   }
    //   returnGear.fault = globals.errorCheck(rep.statusCode, rep.reasonPhrase);
    // }
    // return returnGear;
  }

  void dispose() {
    onCodeReceived.close();
  }
}
