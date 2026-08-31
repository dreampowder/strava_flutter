import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:strava_client/src/data/repository/client.dart';
import 'package:strava_client/src/domain/model/model_route.dart';
import 'package:strava_client/src/domain/repository/repository_route.dart';

class RepositoryRouteImpl extends RepositoryRoute {
  @override
  Future<Route> getRoute(int routeId) {
    return ApiClient.getRequest(
      endPoint: "/v3/routes/$routeId",
      dataConstructor: (data) =>
          Route.fromJson(Map<String, dynamic>.from(data)),
    );
  }

  @override
  Future<List<Route>> listAthleteRoutes(int athleteId, int page, int perPage) {
    return ApiClient.getRequest(
      endPoint: "/v3/athletes/$athleteId/routes",
      queryParameters: {"page": page, "per_page": perPage},
      dataConstructor: (data) {
        if (data is List) {
          return data
              .map((e) => Route.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }
        return [];
      },
    );
  }

  @override
  Future<Uint8List> exportRouteGPX(int routeId) {
    return _exportRoute(routeId, "gpx");
  }

  @override
  Future<Uint8List> exportRouteTCX(int routeId) {
    return _exportRoute(routeId, "tcx");
  }

  Future<Uint8List> _exportRoute(int routeId, String format) {
    return ApiClient.getRequest(
      endPoint: "/v3/routes/$routeId/export_$format",
      responseType: ResponseType.bytes,
      dataConstructor: (data) => data is Uint8List
          ? data
          : Uint8List.fromList(List<int>.from(data)),
    );
  }
}
