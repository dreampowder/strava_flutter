// id_str : "aeiou"
// activity_id : 6
// external_id : "aeiou"
// id : 0
// error : "aeiou"
// status : "aeiou"
class UploadResponse {
  String? idStr;
  int? activityId;
  String? externalId;
  int? id;
  String? error;
  String? status;

  UploadResponse(
      {this.idStr,
      this.activityId,
      this.externalId,
      this.id,
      this.error,
      this.status});

  UploadResponse.fromJson(dynamic json) {
    idStr = json['id_str'];
    activityId = json['activity_id'];
    externalId = json['external_id'];
    id = json['id'];
    error = json['error'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id_str'] = idStr;
    map['activity_id'] = activityId;
    map['external_id'] = externalId;
    map['id'] = id;
    map['error'] = error;
    map['status'] = status;
    return map;
  }
}
