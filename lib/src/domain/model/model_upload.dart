// id_str : "aeiou"
// activity_id : 6
// external_id : "aeiou"
// id : 0
// error : "aeiou"
// status : "aeiou"
import 'package:json_annotation/json_annotation.dart';

part 'model_upload.g.dart';

@JsonSerializable()
class UploadResponse {
  @JsonKey(name: "id_str")
  String? idStr;

  @JsonKey(name: "activity_id")
  int? activityId;

  @JsonKey(name: "external_id")
  String? externalId;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "error")
  String? error;

  @JsonKey(name: "status")
  String? status;

  UploadResponse({
    this.idStr,
    this.activityId,
    this.externalId,
    this.id,
    this.error,
    this.status,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}
