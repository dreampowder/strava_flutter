import 'package:strava_client/common/injections.dart';
import 'package:strava_client/common/local_storage.dart';
import 'package:strava_client/common/session_manager.dart';
import 'package:strava_client/domain/model/model_authentication_response.dart';
import 'package:strava_client/domain/repository/repository_activity.dart';
import 'package:strava_client/domain/repository/repository_athlete.dart';
import 'package:strava_client/domain/repository/repository_authentication.dart';
import 'package:strava_client/domain/repository/repository_club.dart';
import 'package:strava_client/domain/repository/repository_gear.dart';
import 'package:strava_client/domain/repository/repository_route.dart';
import 'package:strava_client/domain/repository/repository_running_race.dart';
import 'package:strava_client/domain/repository/repository_segment.dart';
import 'package:strava_client/domain/repository/repository_segment_effort.dart';
import 'package:strava_client/domain/repository/repository_stream.dart';
import 'package:strava_client/domain/repository/repository_upload.dart';

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

  /// Create a new [StravaClient] from your `Client ID` and `Client Secret`.
  ///
  /// To get these values, follow
  /// [these instructions](https://developers.strava.com/docs/getting-started/#account)
  /// from Strava's documentation.
  StravaClient({
    required this.secret,
    required this.clientId,
    String applicationName = "",
  }) {
    initServiceLocator();
    sl<SessionManager>().initialize(
        secret: secret, clientId: clientId, applicationName: applicationName);
  }

  /// Returns stored strava [TokenResponse] if needed.
  /// returns null if there is no logged in user
  Future<TokenResponse?> getStravaAuthToken() {
    return LocalStorageManager.getToken();
  }
}
