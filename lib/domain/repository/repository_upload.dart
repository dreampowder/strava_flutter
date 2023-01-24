import 'package:strava_client/domain/model/model_upload.dart';
import 'package:strava_client/domain/model/model_upload_request.dart';

abstract class RepositoryUpload{
  Future<UploadResponse> uploadActivity(UploadActivityRequest request);
  Future<UploadResponse> getUpload(int uploadId);
}