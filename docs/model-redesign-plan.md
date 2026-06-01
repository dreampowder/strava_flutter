# Non-breaking redesign plan: `StreamSet` and `Zones`

Two models diverge semantically from the Strava spec (`openapi/strava_v3.*`).
Both can be corrected without breaking existing users by **keeping the current
classes/methods, deprecating them, and adding correct ones alongside**.

---

## 1. `StreamSet` — misnamed (low risk)

### Current state
`model_stream_set.dart` defines `StreamSet` as a **single stream**:
`{type, data, series_type, original_size, resolution}`. The stream repository
returns `List<StreamSet>` and parses the **array form** of the Strava
`/streams` endpoints (the default, `key_by_type=false`).

### Spec
Spec `StreamSet` is an **object keyed by channel** (the `key_by_type=true`
form) with 11 optional typed channels: `time, distance, latlng, altitude,
velocity_smooth, heartrate, cadence, watts, temp, moving, grade_smooth`. Each
channel is a typed stream extending `BaseStream`
(`original_size, resolution, series_type` + a typed `data` array).

### Assessment
The current behavior is **correct for the array form** the client requests —
only the **name** is wrong (a single stream is called `StreamSet`). No data bug.

### Plan (non-breaking)
1. Add `StravaStream` class = exact current `StreamSet` shape (the per-channel
   stream). Make `StreamSet` a `@Deprecated('Renamed to StravaStream')`
   subclass/alias kept for source compatibility.
2. Add a real `StreamSet` keyed-object model (rename conflict handled by doing
   this in a **new file**, e.g. `model_stream_collection.dart`, class
   `StreamCollection` with 11 `StravaStream?` channel fields) so we don't
   shadow the deprecated name.
3. Repository: keep `getActivityStreams(... )` etc. returning
   `List<StreamSet>`; add overloads `getActivity*StreamsByType(...)` returning
   `StreamCollection` (request with `key_by_type=true`).
4. Changelog: document the rename + new keyed API; remove deprecated members in
   the next major.

### Effort: small. Risk: none (additive + deprecation).

---

## 2. `Zones` — latent bug (medium risk, worth fixing)

### Current state
- `model_zones.dart` `Zones` = `{distribution_buckets, type, resource_state,
  sensor_based, ...}` — this is actually the spec's **`ActivityZone`** shape.
- `RepositoryAthlete.getZones()` → `GET /athlete/zones`, parsed as
  `List<Zones>` by mapping over the response as if it were an array.

### Spec
`GET /athlete/zones` returns a **single `Zones` object**, not an array:
```
Zones { heart_rate: HeartRateZoneRanges, power: PowerZoneRanges }
HeartRateZoneRanges { custom_zones: bool, zones: ZoneRange[] }
PowerZoneRanges     { zones: ZoneRange[] }
ZoneRange { min: int, max: int }
```
The array-of-zone shape the current code expects belongs to
`GET /activities/{id}/zones` (→ `ActivityZone[]`), which is **already handled
correctly** by `RepositoryActivity.getActivityZones`.

### Assessment
`getZones()` mismodels its endpoint: it expects an array of activity-zone
objects but the endpoint returns one `{heart_rate, power}` object. This is a
**real bug** — likely returns empty/garbage today.

### Plan (non-breaking)
1. Add correct models (new file `model_athlete_zones.dart`):
   `AthleteZones { HeartRateZoneRanges? heartRate; PowerZoneRanges? power; }`,
   `HeartRateZoneRanges`, `PowerZoneRanges`, `ZoneRange` — all
   `@JsonSerializable`.
2. Add `RepositoryAthlete.getAthleteZones()` returning `Future<AthleteZones>`
   (parses the object form).
3. `@Deprecated('Mismodels /athlete/zones; use getAthleteZones()')` on the old
   `getZones()`; leave its signature/behavior untouched so callers still
   compile.
4. Optionally rename the current `Zones` class → `ActivityZone`-aligned name via
   a deprecated alias (it overlaps conceptually with the existing
   `ActivityZone`; verify before merging).
5. Changelog: document the new method + deprecation; remove old in next major.

### Effort: medium. Risk: low (new method + models; old path deprecated, not changed).

---

## Rollout order
1. Ship `StravaStream`/`StreamCollection` + deprecations.
2. Ship `AthleteZones` + `getAthleteZones()` + deprecate `getZones()`.
3. Bump minor version; announce deprecations in CHANGELOG.
4. Next major: drop deprecated `StreamSet` alias, `getZones()`.
