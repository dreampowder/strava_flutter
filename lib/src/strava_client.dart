import 'package:strava_client/src/common/common.dart';
import 'package:strava_client/src/domain/model/model.dart';
import 'package:strava_client/src/domain/repository/repository.dart';

/// A Flutter client for Strava, which supports most of
/// [Strava V3 API operations](https://developers.strava.com/docs/reference/).
///
/// This client contains `repositories` allowing an easy management of the
/// different operations with Strava's API.
///
/// Some usage examples:
/// ```dart
/// // Create the client
/// StravaClient myStravaClient = StravaClient(
///   secret: 'my-strava-secret',
///   clientId: 'my-strava-client-id',
///   applicationName: 'my-awesome-app',
/// );
///
/// // Authenticate and authorize your app to access your Strava's data
/// await myStravaClient.authentication.authenticate(
///   scopes: [
///     AuthenticationScope.activity_read_all,
///   ],
///   redirectUrl: 'my.cool.app://redirect',
///   callBackUrlScheme: 'my.cool.app',
/// );
///
/// // Get some of your activities
/// var myActivities =
///     await myStravaClient.activities.listLoggedInAthleteActivities(
///   DateTime.now(),
///   DateTime(1999),
///   1,
///   30,
/// );
/// ```
class StravaClient {
  /// Create a new [StravaClient] from your `Client ID` and `Client Secret`.
  ///
  /// To get these values, follow
  /// [these instructions](https://developers.strava.com/docs/getting-started/#account)
  /// from Strava's documentation.
  StravaClient({
    required this.secret,
    required this.clientId,
    String applicationName = '',
  }) {
    initServiceLocator();
    sl<SessionManager>().initialize(
      secret: secret,
      clientId: clientId,
      applicationName: applicationName,
    );
  }

  /// Your Strava `client secret` generated for your *API Application*.
  final String secret;

  /// Your Strava `client ID` generated for your *API Application*.
  final String clientId;

  /// Repository managing all `athletes` operations such as
  /// [RepositoryAthlete.getAthleteStats] or [RepositoryAthlete.updateAthlete].
  RepositoryAthlete get athletes => sl();

  /// Repository managing `authentication`.
  RepositoryAuthentication get authentication => sl();

  /// Repository managing all `activities` operations.
  RepositoryActivity get activities => sl();

  /// Repository managing all `gears` operations.
  RepositoryGear get gears => sl();

  /// Repository managing all `routes` operations.
  RepositoryRoute get routes => sl();

  /// Repository managing all `clubs` operations.
  RepositoryClub get clubs => sl();
  RepositoryRunningRace get runningRaces => sl();

  /// Repository managing all `segmentEfforts` operations.
  RepositorySegmentEffort get segmentEfforts => sl();

  /// Repository managing all `segments` operations.
  RepositorySegment get segments => sl();

  /// Repository managing all `streams` operations.
  RepositoryStream get streams => sl();

  /// Repository managing all `uploads` operations.
  RepositoryUpload get uploads => sl();

  /// Returns stored strava [TokenResponse] if needed.
  /// returns null if there is no logged in user
  Future<TokenResponse?> getStravaAuthToken() {
    return LocalStorageManager.getToken();
  }
}
