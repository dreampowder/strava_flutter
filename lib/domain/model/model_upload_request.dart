import 'dart:io';

/// name : "sdfsdf"
/// description : "sdfsdfsdf"
/// isTrainerActivity : true
/// isCommuteActivity : true
/// dataType : "sdfsdf"
/// externalId : "23424"

class UploadActivityRequest {
  File? file;
  String? name;
  String? description;
  bool? isTrainerActivity;
  bool? isCommuteActivity;
  String? dataType;
  String? externalId;

  UploadActivityRequest({
      this.file,
      this.name, 
      this.description, 
      this.isTrainerActivity, 
      this.isCommuteActivity, 
      this.dataType, 
      this.externalId});

  UploadActivityRequest.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    isTrainerActivity = json['isTrainerActivity'];
    isCommuteActivity = json['isCommuteActivity'];
    dataType = json['dataType'];
    externalId = json['externalId'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['isTrainerActivity'] = isTrainerActivity;
    map['isCommuteActivity'] = isCommuteActivity;
    map['dataType'] = dataType;
    map['externalId'] = externalId;
    return map;
  }

}