import 'package:flutter_test/flutter_test.dart';
import 'package:strava_client/src/domain/model/model_summary_activity.dart';
import 'package:strava_client/src/domain/model/model_summary_athlete.dart';

void main() {
  group('SummaryAthlete (json_serializable)', () {
    final json = {
      "id": 134815,
      "resource_state": 3,
      "firstname": "Marianne",
      "lastname": "Teutenberg",
      "profile_medium": "https://example.com/m.jpg",
      "profile": "https://example.com/l.jpg",
      "city": "San Francisco",
      "state": "CA",
      "country": "US",
      "sex": "F",
      "premium": true,
      "summit": true,
      "created_at": "2017-11-14T02:30:05Z",
      "updated_at": "2018-02-06T19:32:20Z",
    };

    test('fromJson maps every field', () {
      final a = SummaryAthlete.fromJson(json);
      expect(a.id, 134815);
      expect(a.resourceState, 3);
      expect(a.firstname, "Marianne");
      expect(a.lastname, "Teutenberg");
      expect(a.profileMedium, "https://example.com/m.jpg");
      expect(a.sex, "F");
      expect(a.premium, true);
      expect(a.summit, true);
      expect(a.createdAt, "2017-11-14T02:30:05Z");
    });

    test('round-trips to identical JSON', () {
      expect(SummaryAthlete.fromJson(json).toJson(), json);
    });

    test('fromRawJson / toRawJson still work', () {
      final a = SummaryAthlete.fromRawJson(
        '{"id":1,"resource_state":2,"firstname":"A","lastname":"B",'
        '"profile_medium":"m","profile":"p","city":"c","state":"s",'
        '"country":"co","sex":"M","premium":false,"summit":false,'
        '"created_at":"x","updated_at":"y"}',
      );
      expect(a.id, 1);
      expect(a.toRawJson(), contains('"firstname":"A"'));
    });
  });

  group('SummaryActivity (json_serializable)', () {
    test('parses nested athlete + map and snake keys', () {
      final json = {
        "resource_state": 2,
        "athlete": {"id": 134815, "resource_state": 1},
        "name": "Happy Friday",
        "distance": 24931.4,
        "moving_time": 4500,
        "total_elevation_gain": 0, // int in JSON -> double field
        "type": "Ride",
        "id": 154504250376823,
        "max_speed": 11, // int in JSON -> double field
        "map": {"id": "a12345", "summary_polyline": null, "resource_state": 2},
        "start_latlng": [37.83, -122.26],
      };
      final act = SummaryActivity.fromJson(json);
      expect(act.athlete?.id, 134815);
      expect(act.name, "Happy Friday");
      expect(act.distance, 24931.4);
      expect(act.totalElevationGain, 0.0); // int coerced to double
      expect(act.maxSpeed, 11.0);
      expect(act.id, 154504250376823);
      expect(act.map?.id, "a12345");
      expect(act.startLatlng, [37.83, -122.26]);
    });

    test('legacy behavior: missing latlng yields empty list, not null', () {
      final act = SummaryActivity.fromJson({"name": "x"});
      expect(act.startLatlng, isEmpty);
      expect(act.endLatlng, isEmpty);
      expect(act.startLatlng, isNotNull);
    });

    test('toJson omits null athlete and map (legacy behavior)', () {
      final json = SummaryActivity(name: "x", startLatlng: []).toJson();
      expect(json.containsKey('athlete'), false);
      expect(json.containsKey('map'), false);
      expect(json['name'], "x");
    });

    test('toJson includes null scalar keys (legacy behavior)', () {
      final json = SummaryActivity(name: "x").toJson();
      expect(json.containsKey('distance'), true);
      expect(json['distance'], null);
    });
  });
}
