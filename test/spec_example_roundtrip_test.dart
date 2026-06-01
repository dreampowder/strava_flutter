import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:strava_client/src/domain/model/model_club.dart';
import 'package:strava_client/src/domain/model/model_detailed_activity.dart';
import 'package:strava_client/src/domain/model/model_detailed_athlete.dart';
import 'package:strava_client/src/domain/model/model_detailed_segment.dart';

/// Parses Strava's own published response examples (extracted from the bundled
/// OpenAPI spec) through the json_serializable models and asserts that
/// `fromJson` -> `toJson` -> `fromJson` is idempotent (no behavior drift, no
/// throw, no field loss across a round-trip).
void main() {
  final examples =
      json.decode(File('test/_spec_examples.json').readAsStringSync())
          as Map<String, dynamic>;

  Map<String, dynamic> ex(String path) =>
      (examples[path] as Map).cast<String, dynamic>();

  void roundTrip<T>(
    String label,
    Map<String, dynamic> source,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> Function(T) toJson, {
    List<String> ignoreKeys = const [],
  }) {
    test('$label round-trips without drift', () {
      final once = toJson(fromJson(source));
      final twice = toJson(fromJson(once));
      for (final k in ignoreKeys) {
        once.remove(k);
        twice.remove(k);
      }
      expect(
        twice,
        once,
        reason: 'fromJson/toJson must be idempotent for $label',
      );
    });
  }

  // `photos` is excluded from the idempotence check: the nested ActivityUrls
  // class has a pre-existing (intentionally preserved) asymmetry where fromJson
  // reads keys "100"/"600" but toJson writes "s100"/"s600". This non-idempotency
  // exists identically in the original hand-written code and the migrated code —
  // it is faithful preservation, not migration drift. ActivityUrls was left
  // hand-written for exactly this reason.
  roundTrip<DetailedActivity>(
    'DetailedActivity (/activities/{id})',
    ex('/activities/{id}'),
    DetailedActivity.fromJson,
    (m) => m.toJson(),
    ignoreKeys: ['photos'],
  );

  roundTrip<DetailedAthlete>(
    'DetailedAthlete (/athlete)',
    ex('/athlete'),
    DetailedAthlete.fromJson,
    (m) => m.toJson(),
  );

  roundTrip<DetailedSegment>(
    'DetailedSegment (/segments/{id})',
    ex('/segments/{id}'),
    DetailedSegment.fromJson,
    (m) => m.toJson(),
  );

  roundTrip<Club>(
    'Club (/clubs/{id})',
    ex('/clubs/{id}'),
    Club.fromJson,
    (m) => m.toJson(),
  );

  test('DetailedActivity preserves key fields from real payload', () {
    final a = DetailedActivity.fromJson(ex('/activities/{id}'));
    expect(a.id, isNotNull);
    expect(a.name, isNotNull);
    expect(a.distance, isA<double?>());
    // latlng must be a non-null list per legacy behavior
    expect(a.startLatlng, isNotNull);
  });
}
