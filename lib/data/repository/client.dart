
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:strava_flutter/common/session_manager.dart';
import 'package:strava_flutter/injections.dart';
import 'package:strava_flutter/models/strava_fault.dart';

class ApiClient{

  static const _baseUrl = "https://www.strava.com/api";

  static Future<Dio> _getDioClient({bool isAuthenticated = true}) async{
    var dio = Dio();
    if(isAuthenticated){
      var token = await sl<SessionManager>().getToken();
      var headers = Map<String,dynamic>();
      if (token != null) {
        print("Token: ${token.accessToken}");
        headers.putIfAbsent("Authorization", () => "Bearer ${token.accessToken}");
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
          client.get("$_baseUrl$endPoint",queryParameters: queryParameters)
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
      client.post("$_baseUrl$endPoint",queryParameters: queryParameters,data: postBody)
          .then((response)=>completer.complete(dataConstructor(response.data)))
          .catchError((error,stackTrace)=>handleError(completer, error, stackTrace));
    });
    return completer.future;
  }

  static Future<T> putRequest<T>(
      {required  String endPoint,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? postBody,
        required T Function(dynamic) dataConstructor}) async{
    var completer = Completer<T>();
    _getDioClient()
        .then((client){
      client.put("$_baseUrl$endPoint",queryParameters: queryParameters,data: postBody)
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
      debugPrint("Unhandled error: $error");
      debugPrint("Unhandled error: $stackTrace");
      completer.completeError(error,stackTrace);
    }
  }
}