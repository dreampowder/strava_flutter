## [2.3.0]
Backwards compatible (additions + deprecations only).

### Added
- Automatic access-token refresh: every authenticated request now transparently
  refreshes an expired token via the stored refresh token before sending
  (`SessionManager.getValidToken()`), with concurrent requests sharing a single
  in-flight refresh. Previously an expired token caused requests to fail.
- `RepositoryGear.getGearById(String gearId)` — gear ids are strings
  (e.g. `b1234567`), which the old `int`-typed method could not represent.

### Deprecated
- `RepositoryGear.getGear(int gearId)` — use `getGearById(String)`.

## [2.2.0]
Modernization pass — fully backwards compatible (additions + deprecations only).

### Added
- Bundled, validated OpenAPI 3.0 + Swagger 2.0 specs for the Strava V3 API under `openapi/` (reference artifacts; not shipped in the package).
- Missing fields on existing models, sourced from the spec: `sport_type` (the modern replacement for the deprecated `type`), `elev_high`, `elev_low`, `device_name`, `hide_from_home`, `upload_id_str`, `best_efforts`, `splits_standard` (activities); `activity_id`, `average_heartrate`, `max_heartrate`, `is_kom` (segment efforts); `summit` (athlete); `athlete_pr_effort` (segment); `pace_zone` (lap); `waypoints` + new `Waypoint` model (route); `activity_types` (club).
- `StreamCollection` model + `RepositoryStream.get*StreamsByType(...)` methods for Strava's keyed (`key_by_type=true`) stream form.
- `AthleteZones` model (`heart_rate` / `power` ranges) + `RepositoryAthlete.getAthleteZones()`, the correct model for `GET /athlete/zones`.

### Changed
- All models migrated to `json_serializable` (generated `*.g.dart`). Public API, field names, types, nullability and serialization output are unchanged.
- `RepositoryStream.get*Streams(...)` now correctly request the array form and return populated `List<StravaStream>` (previously returned an empty list due to a `key_by_type` mismatch).
- SDK constraint raised to `>=3.8.0 <4.0.0`.

### Deprecated
- `StreamSet` → renamed to `StravaStream` (kept as a deprecated alias; a single stream is not a "set").
- `RepositoryAthlete.getZones()` / its `List<Zones>` shape — mismodels `GET /athlete/zones`; use `getAthleteZones()`.

## [2.1.3]
- Fixed toJson() call for ModelDetailedActivity (Thanks @tchex)
- Updated project dependencies

## [2.1.2]

- Updated web_auth into flutter_web_auth_2 (thanks to @ChrisElliotUK)
- Change unilinks dependency into app_links (thanks to @ChrisElliotUK)

## [2.1.1]

- Removed unnecessary print statement (thanks to @ChrisElliotUK)

## [2.1.0]

- Code cleanup and refactoring (thanks to @Nenuphar12) 
- Added Support for authenticate via native Strava app from ios if available
- Updated Readme.md for additional ios directives for native strava app authentication

## [2.0.3]
- First of all, Thanks a lot to all contributors. 
- [FIX] Issue #87 : Fails to auth on Android fix by @ChrisElliotUK
- [CHORE] Dependency cleanup @Nenuphar12 (thanks a lot)
- [FEATURE] Added PreferEphemeral pass through for auth by @withu-william
- [DOCUMENTATION] Improved code documentation by @Nenuphar12
- [FIX] updated dio package version by @dreampowder


## [2.0.0]
A Complete rewrite of the entire package. Thanks to https://www.github.com/birdyf for giving us a good headstart.
Warning, this version has no backwards compability and you have to re-implement everything. 

## [1.2.2+61]
Added getSegmentEffortById
Modification in AdroidManifest.xml to have authentication working with Firefox (not only Chrome)

## [1.2.1+51] 
Changed urlScheme from strava to stravaflutter used in url redirect to avoid conflict with strava app when installed in the mobile

## [1.2.0+45] 
Fix bug in _saveToken 


## [1.1.0+37] 
Fix user agent disallowed when selecting Google in Strava Auth page

## [1.0.12] 
Store the potentially new refresh token when getting new access token

## [1.0.11]  
 removed lines in test

## [1.0.10]  
added strava_prefix to preferences key

