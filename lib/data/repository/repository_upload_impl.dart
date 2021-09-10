import 'package:dio/dio.dart';
import 'package:strava_flutter/data/repository/client.dart';
import 'package:strava_flutter/domain/model/model_upload.dart';
import 'package:strava_flutter/domain/model/model_upload_request.dart';
import 'package:strava_flutter/domain/repository/repository_upload.dart';

class RepositoryUploadImpl extends RepositoryUpload{
  
  @override
  Future<UploadResponse> getUpload(int uploadId) {
    return ApiClient.getRequest(endPoint: "/v3/uploads/$uploadId", dataConstructor: (data)=>UploadResponse.fromJson(Map<String,dynamic>.from(data)));
  }

  @override
  Future<UploadResponse> uploadActivity(UploadActivityRequest request) async{
    FormData formData = FormData.fromMap(request.toJson());
    if(request.file != null){
      var multipartFile = await MultipartFile.fromFile(request.file!.path);
      formData.files.add(MapEntry("file", multipartFile));
    }
    return ApiClient.postRequest(endPoint: "/v3/uploads",postBody: formData, dataConstructor: (data)=>UploadResponse.fromJson(Map<String,dynamic>.from(data)));
    
  }
  
}