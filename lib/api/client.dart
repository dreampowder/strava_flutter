
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:strava_flutter/common/json_serializable_mixin.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/models/strava_fault.dart';

class ApiClient{

  static const baseUrl = "https://www.strava.com/api/v3";

  static Future<Dio> getDioClient({bool isAuthenticated = true}) async{
    var dio = Dio();
    if(isAuthenticated){
      var token = await SessionManager.getInstance.getToken();
      var headers = Map<String,dynamic>();
      if (token != null) {
        headers.putIfAbsent("Authorization", () => "Bearer $token");
      }
      dio.options = BaseOptions(headers: headers);
    }
    return Future.value(dio);
  }

  static Future<T> getRequest<T>(String endPoint, Map<String, dynamic> queryParameters,T Function(dynamic) dataConstructor) async{
    var completer = Completer<T>();
    getDioClient()
        .then((client){
          client.get(baseUrl,queryParameters: queryParameters)
              .then((response)=>completer.complete(dataConstructor(response.data)))
              .catchError((error,stackTrace)=>handleError(completer, error, stackTrace));
    });
    return completer.future;
  }

  static void handleError<T>(Completer<T> completer,dynamic error,StackTrace stackTrace){
    if(error is DioError){
      if(error.response != null && error.response?.data != null && error.response?.data is Map){
        var stravaFault = StravaFault.fromJson(Map<String,dynamic>.from(error.response?.data));
        completer.completeError(stravaFault);
      }else{
        completer.completeError(error,stackTrace);
      }
    }else{
      completer.completeError(error,stackTrace);
    }
  }
}