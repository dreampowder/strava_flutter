import 'package:strava_flutter/domain/model/model_club.dart';
import 'package:strava_flutter/domain/model/model_summary_activity.dart';
import 'package:strava_flutter/domain/model/model_summary_athlete.dart';
import 'package:strava_flutter/domain/model/model_summary_club.dart';

abstract class RepositoryClub{

  Future<List<SummaryActivity>> listClubActivities(int clubId, int page, int perPage);
  Future<List<SummaryAthlete>> listClubAdministrators(int clubId, int page, int perPage);
  Future<List<SummaryAthlete>> listClubMembers(int clubId, int page, int perPage);
  Future<List<SummaryClub>> getLoggedInAthleteClubs(int page, int perPage);

  Future<Club> getClub(int clubId);
}