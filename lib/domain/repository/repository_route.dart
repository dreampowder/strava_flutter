import 'dart:typed_data';

import 'package:strava_client/domain/model/model_route.dart';

abstract class RepositoryRoute{
  Future<Route> getRoute(int routeId);
  Future<List<Route>> listAthleteRoutes(int athleteId, int page, int perPage);
  Future<Uint8List> exportRouteGPX(int routeId);
  Future<Uint8List> exportRouteTCX(int routeId);
}