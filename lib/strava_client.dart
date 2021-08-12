import 'package:strava_flutter/api/repositories/athletes.dart';
import 'package:strava_flutter/api/repositories/authentication.dart';
import 'package:strava_flutter/api/repositories/clubs.dart';
import 'package:strava_flutter/common/session_manager.dart';

class StravaClient
    with
        StravaAuthenticationRepository,
        AthletesRepository,
        ClubsRepository
{
  final String secret;
  final String clientId;
  StravaClient(this.secret, this.clientId){
    SessionManager.getInstance.initialize(secret: secret, clientId: clientId);
    print("Initialized :${SessionManager.getInstance.clientId}");
  }
}