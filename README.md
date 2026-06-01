# strava_client

[![pub package](https://img.shields.io/pub/v/strava_client.svg)](https://pub.dev/packages/strava_client)
[![CI](https://github.com/dreampowder/strava_flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/dreampowder/strava_flutter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An unofficial Flutter client for the [Strava V3 API](https://developers.strava.com/docs/reference/).

It handles the OAuth2 flow (including the native Strava app on iOS), automatic
token storage and refresh, and gives you typed models and repositories for the
Strava endpoints.

- 🔐 OAuth2 authentication with automatic token refresh
- 🧩 Typed request/response models (generated with `json_serializable`)
- 🗂️ Repository-per-domain API (athletes, activities, segments, …)
- ⚠️ Structured error handling via `Fault`
- 📖 Bundled, validated [OpenAPI specs](openapi/) for the Strava API

> Looking for a hands-on tour? The [example app](example/) is an interactive
> API explorer that lets you log in and run every call against your account.

## Table of contents

- [Installation](#installation)
- [Quick start](#quick-start)
- [Platform setup](#platform-setup)
- [Authentication](#authentication)
- [Making API calls](#making-api-calls)
- [Error handling](#error-handling)
- [Supported endpoints](#supported-endpoints)
- [Example app](#example-app)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
- [License](#license)

## Installation

Add the package:

```bash
flutter pub add strava_client
```

or in `pubspec.yaml`:

```yaml
dependencies:
  strava_client: ^2.3.0
```

Requires Dart `>=3.8.0`.

## Quick start

```dart
import 'package:strava_client/strava_client.dart';

final stravaClient = StravaClient(
  clientId: "YOUR_CLIENT_ID",
  secret: "YOUR_CLIENT_SECRET",
);

Future<void> main() async {
  // 1. Authenticate (opens the Strava login / consent screen).
  final token = await stravaClient.authentication.authenticate(
    scopes: [
      AuthenticationScope.profile_read_all,
      AuthenticationScope.read_all,
      AuthenticationScope.activity_read_all,
    ],
    redirectUrl: "stravaflutter://redirect",
    callbackUrlScheme: "stravaflutter",
  );
  print("Access token: ${token.accessToken}");

  // 2. Call the API — the token is attached (and refreshed) automatically.
  final athlete = await stravaClient.athletes.getAuthenticatedAthlete();
  print("Hello ${athlete.firstname}!");
}
```

Create the client **once** and reuse it (it wires up shared session state).

## Platform setup

The redirect URL scheme used in the snippets below is `stravaflutter://redirect`.
In your [Strava API settings](https://www.strava.com/settings/api) set the
**Authorization Callback Domain** to `redirect`.

### Android

Add the callback activity to `android/app/src/main/AndroidManifest.xml`:

```xml
<activity
    android:name="com.linusu.flutter_web_auth_2.CallbackActivity"
    android:exported="true">
    <intent-filter android:label="flutter_web_auth_2">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:host="redirect" android:scheme="stravaflutter" />
    </intent-filter>
</activity>
```

Set `android:launchMode="singleTop"` on your main activity and remove any
`android:taskAffinity` entries.

> On Android 9 (API 28) the auth webview can throw
> `net::ERR_CLEARTEXT_NOT_PERMITTED`. If so, add
> `android:usesCleartextTraffic="true"` to your `<application>` tag.

### iOS

Add the URL scheme to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>stravaflutter</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>stravaflutter</string>
        </array>
    </dict>
</array>
```

To let users authenticate through the native Strava app when installed, also add:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>strava</string>
</array>
```

> The web platform is not supported (the OAuth redirect does not return to the
> app). Use Android or iOS.

## Authentication

```dart
// Authenticate. If a valid token is already stored it is reused; an expired
// token is refreshed automatically.
final TokenResponse token = await stravaClient.authentication.authenticate(
  scopes: [AuthenticationScope.activity_read_all],
  redirectUrl: "stravaflutter://redirect",
  callbackUrlScheme: "stravaflutter",
  forceShowingApproval: false, // force the consent screen even if already granted
  preferEphemeral: true,       // iOS: don't share cookies with Safari
);

// Revoke access and clear the stored token.
await stravaClient.authentication.deAuthorize();
```

Available scopes (`AuthenticationScope`): `read`, `read_all`,
`profile_read_all`, `profile_write`, `activity_read`, `activity_read_all`,
`activity_write`.

### Token storage & refresh

Tokens are persisted with `shared_preferences` and reused across launches. On
every authenticated request the client checks expiry and **transparently
refreshes** the access token using the stored refresh token, so you don't have
to manage refresh yourself.

## Making API calls

Calls are grouped into repositories on the client:

| Getter | Repository |
|--------|------------|
| `stravaClient.authentication` | OAuth |
| `stravaClient.athletes` | Athlete |
| `stravaClient.activities` | Activities |
| `stravaClient.clubs` | Clubs |
| `stravaClient.gears` | Gear |
| `stravaClient.routes` | Routes |
| `stravaClient.runningRaces` | Running races |
| `stravaClient.segments` | Segments |
| `stravaClient.segmentEfforts` | Segment efforts |
| `stravaClient.streams` | Streams |
| `stravaClient.uploads` | Uploads |

```dart
// Recent activities
final activities = await stravaClient.activities.listLoggedInAthleteActivities(
  DateTime.now(),                              // before
  DateTime.now().subtract(Duration(days: 30)), // after
  1,                                           // page
  30,                                          // per page
);

// A detailed segment
final segment = await stravaClient.segments.getSegment(229781);

// Activity streams keyed by type
final streams = await stravaClient.streams.getActivityStreamsByType(
  12345678,
  ["distance", "heartrate", "watts"],
);
```

## Error handling

Failed requests throw a typed `Fault`:

```dart
try {
  await stravaClient.athletes.getAuthenticatedAthlete();
} on Fault catch (fault) {
  print("message: ${fault.message}");
  for (final e in fault.errors ?? []) {
    print("  ${e.resource}.${e.field}: ${e.code}");
  }
}
```

## Supported endpoints

<details>
<summary><b>Athlete</b></summary>

- `getAuthenticatedAthlete`
- `getAthleteZones` (heart-rate & power zones)
- `getAthleteStats`
- `updateAthlete`
</details>

<details>
<summary><b>Activities</b></summary>

- `getActivity`
- `listLoggedInAthleteActivities`
- `listActivityComments`
- `listActivityKudoers`
- `getLapsByActivityId`
- `getActivityZones`
- `createActivity`
- `updateActivity`
</details>

<details>
<summary><b>Clubs</b></summary>

- `getClub`
- `getLoggedInAthleteClubs`
- `listClubActivities`
- `listClubAdministrators`
- `listClubMembers`
</details>

<details>
<summary><b>Gear / Routes / Running races</b></summary>

- `gears.getGearById`
- `routes.getRoute`, `routes.listAthleteRoutes`, `routes.exportRouteGPX`, `routes.exportRouteTCX`
- `runningRaces.listRunningRaces`, `runningRaces.getRage`
</details>

<details>
<summary><b>Segments & efforts</b></summary>

- `segments.getSegment`
- `segments.listStarredSegments`
- `segments.exploreSegments`
- `segments.getLeaderBoard`
- `segments.starSegment`
- `segmentEfforts.getSegmentEffort`, `segmentEfforts.listSegmentEfforts`
</details>

<details>
<summary><b>Streams & uploads</b></summary>

- `streams.getActivityStreams` / `getActivityStreamsByType`
- `streams.getRouteStreams` / `getRouteStreamsByType`
- `streams.getSegmentStreams` / `getSegmentStreamsByType`
- `streams.getSegmentEffortStreams` / `getSegmentEffortStreamsByType`
- `uploads.uploadActivity`, `uploads.getUpload`
</details>

To upload activities you can generate TCX files with the
[`rw_tcx`](https://pub.dev/packages/rw_tcx) package.

Missing an endpoint? [Open an issue](https://github.com/dreampowder/strava_flutter/issues)
or send a PR — the repository pattern makes new calls easy to add.

## Example app

The [`example/`](example/) directory is a full **API Explorer**: log in with
OAuth, pick any call from a grouped list, fill in its parameters, and see the
pretty-printed JSON response (or `Fault`).

```bash
cd example
cp lib/secret.dart.example lib/secret.dart   # add your clientId + secret
flutter run
```

## Contributing

Contributions are welcome! Please:

1. Open an issue for bugs or feature requests.
2. For PRs: keep changes backwards compatible where possible, run
   `dart analyze` and `flutter test`, and add tests where it makes sense.

CI runs analysis and tests on every PR.

## Acknowledgements

- [@Birdyf](https://github.com/Birdyf) for the original package.
- Patrick Finkelstein, the package's original maintainer.
- [Joe Birch](https://github.com/hitherejoe/FlutterOAuth) — OAuth reference.
- Strava's published [Swagger spec](https://developers.strava.com/swagger/),
  bundled and validated under [`openapi/`](openapi/).

## License

[MIT](LICENSE) — Copyright (c) 2019-present Serdar Coşkun and contributors.
