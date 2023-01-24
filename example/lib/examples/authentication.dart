import 'package:strava_client/domain/model/model_authentication_response.dart';
import 'package:strava_client/domain/model/model_authentication_scopes.dart';
import 'package:strava_client/strava_client.dart';

class ExampleAuthentication{
  final StravaClient stravaClient;
  ExampleAuthentication(this.stravaClient);

  Future<TokenResponse> testAuthentication(List<AuthenticationScope> scopes, String redirectUrl){

    return stravaClient.authentication.authenticate(scopes: scopes, redirectUrl: redirectUrl);
  }

  Future<void> testDeauthorize(){
    return stravaClient.authentication.deAuthorize();
  }
}