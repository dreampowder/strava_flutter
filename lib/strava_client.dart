import 'package:strava_flutter/api/repositories/authentication.dart';
import 'package:strava_flutter/common/session_manager.dart';

class StravaClient
    with StravaAuthentication{
  final String secret;
  final String clientId;
  StravaClient(this.secret, this.clientId){
    SessionManager.getInstance.initialize(secret: secret, clientId: clientId);
  }
}