import 'package:strava_flutter/api/repositories/athletes.dart';
import 'package:strava_flutter/api/repositories/authentication.dart';
import 'package:strava_flutter/api/repositories/clubs.dart';
import 'package:strava_flutter/common/local_storage.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/models/token.dart';

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

  ///Returns stored strava token if needed.
  ///returns null if there is no logged in user
  Future<Token?> getStravaAuthToken(){
    return LocalStorageManager.getToken();
  }
}