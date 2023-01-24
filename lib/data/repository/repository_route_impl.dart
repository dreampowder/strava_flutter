import 'dart:typed_data';

import 'package:strava_client/data/repository/client.dart';
import 'package:strava_client/domain/model/model_route.dart';
import 'package:strava_client/domain/repository/repository_route.dart';

class RepositoryRouteImpl extends RepositoryRoute{
  @override
  Future<Route> getRoute(int routeId) {
    return ApiClient.getRequest(endPoint: "/v3/routes/$routeId", dataConstructor: (data)=>Route.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<List<Route>> listAthleteRoutes(int athleteId, int page, int perPage) {
    return ApiClient.getRequest(endPoint: "/v3/athletes/$athleteId/routes",queryParameters: {"page":page, "per_page":perPage} , dataConstructor: (data){
      if(data is List){
        return data.map((e) => Route.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      return [];
    });
  }

  @override
  Future<Uint8List> exportRouteGPX(int routeId) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> exportRouteTCX(int routeId) {
    // TODO: implement exportRouteTCX
    throw UnimplementedError();
  }
}