import 'dart:io';

// name : "sdfsdf"
// description : "sdfsdfsdf"
// isTrainerActivity : true
// isCommuteActivity : true
// dataType : "sdfsdf"
// externalId : "23424"
class UploadActivityRequest {
  File? file;
  String? name;
  String? description;
  bool? isTrainerActivity;
  bool? isCommuteActivity;
  String? dataType;
  String? externalId;

  UploadActivityRequest(
      {this.file,
      this.name,
      this.description,
      this.isTrainerActivity,
      this.isCommuteActivity,
      this.dataType,
      this.externalId});

  UploadActivityRequest.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    isTrainerActivity = json['trainer'];
    isCommuteActivity = json['commute'];
    dataType = json['data_type'];
    externalId = json['external_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['trainer'] = isTrainerActivity;
    map['commute'] = isCommuteActivity;
    map['data_type'] = dataType;
    map['external_id'] = externalId;
    return map;
  }
}
