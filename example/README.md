# Strava Client Explorer (example app)

An interactive playground for the `strava_client` package. Log in with OAuth,
then run **every** repository call from a form and inspect the pretty-printed
JSON response (or the Strava `Fault` on error).

## What it covers

- OAuth login / de-authorization, with the access token shown and copyable.
- A grouped list of API calls (Athlete, Activity, Club, Gear, Route, Running
  races, Segment efforts, Segment, Stream, Upload).
- A generated input form per call (ints, doubles, strings, dates, enums,
  booleans, comma-separated key lists) so you can pass real parameters.
- Read calls and a few write calls (`createActivity`, `updateActivity`,
  `starSegment`) — write calls are tagged **WRITE** and mutate your data.
- Pretty-printed JSON responses with a copy button.

## Setup

1. Create a Strava API application at <https://www.strava.com/settings/api>.
   Set the **Authorization Callback Domain** to match the redirect used here
   (`stravaflutter://redirect`).
2. Copy the credentials template and fill it in:

   ```bash
   cp lib/secret.dart.example lib/secret.dart
   # edit lib/secret.dart -> clientId + secret
   ```

   `lib/secret.dart` is git-ignored.
3. Run on a device or simulator:

   ```bash
   flutter pub get
   flutter run
   ```

> Note: the app targets mobile (iOS/Android). OAuth uses native / in-app
> browser flows via `flutter_web_auth_2`; the web target is not supported.

## Adding a new call

Calls are declared declaratively in
[`lib/api/api_registry.dart`](lib/api/api_registry.dart) as `ApiCall` entries
(group, name, params, and a `run` closure). The UI builds the form and result
view automatically — no per-call widget code needed.
