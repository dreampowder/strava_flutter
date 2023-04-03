import 'dart:typed_data';

import 'package:strava_client/src/domain/model/model.dart';

abstract class RepositoryRoute {
  /// Returns a [Route] from its [routeId].
  ///
  /// Requires [AuthenticationScope.read_all] for `private` routes.
  ///
  /// {@macro fault_management}
  Future<Route> getRoute(int routeId);

  /// Returns a list of the [Route]s created by the `athlete` with this
  /// [athleteId].
  ///
  /// {@macro fault_management}
  Future<List<Route>> listAthleteRoutes(int athleteId, int page, int perPage);

  /// Returns a `GPX` file of the route with [routeId] as a [Uint8List].
  ///
  /// Requires [AuthenticationScope.read_all] for `private` routes.
  ///
  /// {@macro fault_management}
  Future<Uint8List> exportRouteGPX(int routeId);

  /// Returns a `TCX` file of the route with [routeId] as a [Uint8List].
  ///
  /// Requires [AuthenticationScope.read_all] for `private` routes.
  ///
  /// {@macro fault_management}
  Future<Uint8List> exportRouteTCX(int routeId);
}
