import 'package:strava_client/src/domain/model/model.dart';

abstract class RepositoryUpload {
  /// Uploads a new data file as an [UploadActivityRequest] to create an
  /// `activity` from and returns an [UploadResponse].
  ///
  /// Requires [AuthenticationScope.activity_write].
  ///
  /// {@macro fault_management}
  Future<UploadResponse> uploadActivity(UploadActivityRequest request);

  /// Returns an [UploadResponse] from [uploadId].
  ///
  /// Requires [AuthenticationScope.activity_write].
  ///
  /// {@macro fault_management}
  Future<UploadResponse> getUpload(int uploadId);
}
