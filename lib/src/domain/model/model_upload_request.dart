import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'model_upload_request.g.dart';

// name : "sdfsdf"
// description : "sdfsdfsdf"
// isTrainerActivity : true
// isCommuteActivity : true
// dataType : "sdfsdf"
// externalId : "23424"
@JsonSerializable()
class UploadActivityRequest {
  @JsonKey(includeFromJson: false, includeToJson: false)
  File? file;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "trainer")
  bool? isTrainerActivity;

  @JsonKey(name: "commute")
  bool? isCommuteActivity;

  @JsonKey(name: "data_type")
  String? dataType;

  @JsonKey(name: "external_id")
  String? externalId;

  UploadActivityRequest({
    this.file,
    this.name,
    this.description,
    this.isTrainerActivity,
    this.isCommuteActivity,
    this.dataType,
    this.externalId,
  });

  factory UploadActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadActivityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadActivityRequestToJson(this);
}
