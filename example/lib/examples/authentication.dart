import 'package:strava_flutter/domain/model/model_authentication_response.dart';
import 'package:strava_flutter/domain/model/model_authentication_scopes.dart';
import 'package:strava_flutter/strava_client.dart';

class ExampleAuthentication {
  final StravaClient stravaClient;
  ExampleAuthentication(this.stravaClient);

  Future<TokenResponse> testAuthentication(List<AuthenticationScope> scopes, String redirectUrl, String callbackUrlScheme) {
    return stravaClient.authentication
        .authenticate(scopes: scopes, redirectUrl: redirectUrl, callbackUrlScheme: callbackUrlScheme);
  }

  Future<void> testDeauthorize() {
    return stravaClient.authentication.deAuthorize();
  }
}
