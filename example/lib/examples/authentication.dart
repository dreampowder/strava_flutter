import 'package:strava_client/strava_client.dart';

class ExampleAuthentication {
  final StravaClient stravaClient;
  ExampleAuthentication(this.stravaClient);

  Future<TokenResponse> testAuthentication(
      List<AuthenticationScope> scopes, String redirectUrl) {
    return stravaClient.authentication.authenticate(
        scopes: scopes,
        redirectUrl: redirectUrl,
        forceShowingApproval: false,
        callbackUrlScheme: "");
  }

  Future<void> testDeauthorize() {
    return stravaClient.authentication.deAuthorize();
  }
}
