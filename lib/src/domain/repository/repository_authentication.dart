import 'package:shared_preferences/shared_preferences.dart';
import 'package:strava_client/src/common/common.dart';
import 'package:strava_client/src/domain/model/model.dart';

/// Repository managing all API calls related to `authentication`.
abstract class RepositoryAuthentication {
  /// Authenticates the user with the requested [AuthenticationScope].
  ///
  /// If a [TokenResponse] is already stored by the [SessionManager] and the
  /// `scopes` have not changed, this `token` is *refreshed* if needed and then
  /// returned.
  ///
  /// Else if there is no stored `token`, the package
  /// [flutter_web_auth_2](https://pub.dev/packages/flutter_web_auth_2) is used to
  /// ask the user to authenticate to Strava using `OAuth2`.
  ///
  /// `redirectUrl` should be the `url` you set up when creating your application
  /// to use Strava API
  /// ([the documentation to do so](https://developers.strava.com/docs/getting-started/#account)).
  /// `callbackUrlScheme` should be a string specifying the scheme of the url
  /// that the page will redirect to upon successful authentication.
  ///
  /// Example :
  /// ```dart
  /// authenticate(
  ///   scopes: [
  ///     AuthenticationScope.activity_read_all,
  ///   ],
  ///   redirectUrl: 'my.cool.app.scheme://redirect',
  ///   callBackUrlScheme: 'my.cool.app.scheme',
  /// );
  /// ```
  Future<TokenResponse> authenticate({
    required List<AuthenticationScope> scopes,
    required String redirectUrl,
    required String callbackUrlScheme,
    bool forceShowingApproval = false,
  });

  /// De authorize the app from accessing the current user's data.
  ///
  /// Needs to be have a valid [TokenResponse] stored or an `error` is thrown.
  ///
  /// The `token` is then deleted (thus removed from the [SharedPreferences]).
  Future<void> deAuthorize();
}
