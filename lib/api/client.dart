
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/models/strava_fault.dart';

class ApiClient{

  static const _baseUrl = "https://www.strava.com/api";

  static Future<Dio> _getDioClient({bool isAuthenticated = true}) async{
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

  static Future<T> getRequest<T>(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      required T Function(dynamic) dataConstructor}) async{
    var completer = Completer<T>();
    _getDioClient()
        .then((client){
          client.get(_baseUrl,queryParameters: queryParameters)
              .then((response)=>completer.complete(dataConstructor(response.data)))
              .catchError((error,stackTrace)=>handleError(completer, error, stackTrace));
    });
    return completer.future;
  }

  static Future<T> postRequest<T>(
      {required  String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? postBody,
      required T Function(dynamic) dataConstructor}) async{
    var completer = Completer<T>();
    _getDioClient()
        .then((client){
      client.post(_baseUrl,queryParameters: queryParameters,data: postBody)
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