import 'package:strava_flutter/common/local_storage.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/repository/repository_athlete.dart';
import 'package:strava_flutter/domain/repository/repository_authentication.dart';
import 'package:strava_flutter/injections.dart';

class StravaClient{
  final String secret;
  final String clientId;

  RepositoryAthlete get athletes => sl();
  RepositoryAuthentication get authentication => sl();

  StravaClient(this.secret, this.clientId){
    initServiceLocator();
    sl<SessionManager>().initialize(secret: secret, clientId: clientId);
  }

  ///Returns stored strava token if needed.
  ///returns null if there is no logged in user
  Future<TokenResponse?> getStravaAuthToken(){
    return LocalStorageManager.getToken();
  }
}