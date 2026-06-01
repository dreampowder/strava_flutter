import 'package:flutter_test/flutter_test.dart';
import 'package:strava_client/src/domain/model/model_athlete_zones.dart';
import 'package:strava_client/src/domain/model/model_stream_collection.dart';
import 'package:strava_client/src/domain/model/model_stream_set.dart';

void main() {
  group('StravaStream (renamed from StreamSet)', () {
    final json = {
      "type": "distance",
      "data": [2.9, 5.8, 8.5, 11.7],
      "series_type": "distance",
      "original_size": 4,
      "resolution": "high",
    };

    test('parses a single stream', () {
      final s = StravaStream.fromJson(json);
      expect(s.type, "distance");
      expect(s.data, [2.9, 5.8, 8.5, 11.7]);
      expect(s.originalSize, 4);
    });

    test('round-trips', () {
      final once = StravaStream.fromJson(json).toJson();
      expect(StravaStream.fromJson(once).toJson(), once);
    });

    test('deprecated StreamSet alias still resolves to StravaStream', () {
      // ignore: deprecated_member_use_from_same_package
      final StreamSet legacy = StravaStream.fromJson(json);
      expect(legacy, isA<StravaStream>());
      expect(legacy.type, "distance");
    });
  });

  group('StreamCollection (keyed stream set)', () {
    final json = {
      "distance": {
        "type": "distance",
        "data": [0.0, 1.0, 2.0],
        "series_type": "distance",
        "original_size": 3,
        "resolution": "high",
      },
      "heartrate": {
        "type": "heartrate",
        "data": [120.0, 130.0, 140.0],
        "series_type": "distance",
        "original_size": 3,
        "resolution": "high",
      },
    };

    test('parses channels keyed by type', () {
      final c = StreamCollection.fromJson(json);
      expect(c.distance?.data, [0.0, 1.0, 2.0]);
      expect(c.heartrate?.data, [120.0, 130.0, 140.0]);
      expect(c.watts, isNull);
    });

    test('round-trips and omits absent channels', () {
      final once = StreamCollection.fromJson(json).toJson();
      expect(StreamCollection.fromJson(once).toJson(), once);
      expect(once.containsKey('watts'), false);
    });
  });

  group('AthleteZones (correct /athlete/zones model)', () {
    final json = {
      "heart_rate": {
        "custom_zones": true,
        "zones": [
          {"min": 0, "max": 115},
          {"min": 115, "max": 152},
          {"min": 152, "max": -1},
        ],
      },
      "power": {
        "zones": [
          {"min": 0, "max": 180},
          {"min": 181, "max": -1},
        ],
      },
    };

    test('parses heart_rate and power zones', () {
      final z = AthleteZones.fromJson(json);
      expect(z.heartRate?.customZones, true);
      expect(z.heartRate?.zones?.length, 3);
      expect(z.heartRate?.zones?.last.max, -1);
      expect(z.power?.zones?.first.max, 180);
    });

    test('round-trips', () {
      final once = AthleteZones.fromJson(json).toJson();
      expect(AthleteZones.fromJson(once).toJson(), once);
    });
  });
}
