// type : "distance"
// data : [2.9,5.8,8.5,11.7,15,19,23.2,28,32.8,38.1,43.8,49.5]
// series_type : "distance"
// original_size : 12
// resolution : "high"
class StreamSet {
  String? type;
  List<double>? data;
  String? seriesType;
  int? originalSize;
  String? resolution;

  StreamSet(
      {this.type,
      this.data,
      this.seriesType,
      this.originalSize,
      this.resolution});

  StreamSet.fromJson(dynamic json) {
    type = json['type'];
    data = json['data'] != null ? json['data'].cast<double>() : [];
    seriesType = json['series_type'];
    originalSize = json['original_size'];
    resolution = json['resolution'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = type;
    map['data'] = data;
    map['series_type'] = seriesType;
    map['original_size'] = originalSize;
    map['resolution'] = resolution;
    return map;
  }
}
