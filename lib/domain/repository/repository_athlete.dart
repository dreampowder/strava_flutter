import 'package:strava_client/domain/model/model_activity_stats.dart';
import 'package:strava_client/domain/model/model_detailed_athlete.dart';
import 'package:strava_client/domain/model/model_zones.dart';

abstract class RepositoryAthlete{
  Future<DetailedAthlete> updateAthlete(double weight);
  Future<ActivityStats> getAthleteStats(int athleteId);
  Future<List<Zones>> getZones();
  Future<DetailedAthlete> getAuthenticatedAthlete();
}