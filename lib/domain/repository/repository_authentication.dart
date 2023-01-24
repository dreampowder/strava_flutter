import 'package:strava_client/domain/model/model_authentication_response.dart';
import 'package:strava_client/domain/model/model_authentication_scopes.dart';

abstract class RepositoryAuthentication {
  Future<TokenResponse> authenticate({
    required List<AuthenticationScope> scopes,
    required String redirectUrl,
    bool forceShowingApproval = false,
    required String callbackUrlScheme,
  });

  Future<void> deAuthorize();
}
