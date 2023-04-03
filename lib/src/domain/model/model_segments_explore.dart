/// segments : [{"id":229781,"resource_state":2,"name":"Hawk Hill","climb_category":1,"climb_category_desc":"4","avg_grade":5.7,"start_latlng":[37.8331119,-122.4834356],"end_latlng":[37.8280722,-122.4981393],"elev_difference":152.8,"distance":2684.8,"points":"}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@","starred":false}]

class ExplorerResponse {
  List<ExplorerSegment>? segments;

  ExplorerResponse({
      this.segments});

  ExplorerResponse.fromJson(dynamic json) {
    if (json['segments'] != null) {
      segments = [];
      json['segments'].forEach((v) {
        segments?.add(ExplorerSegment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (segments != null) {
      map['segments'] = segments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 229781
/// resource_state : 2
/// name : "Hawk Hill"
/// climb_category : 1
/// climb_category_desc : "4"
/// avg_grade : 5.7
/// start_latlng : [37.8331119,-122.4834356]
/// end_latlng : [37.8280722,-122.4981393]
/// elev_difference : 152.8
/// distance : 2684.8
/// points : "}g|eFnpqjVl@En@Md@HbAd@d@^h@Xx@VbARjBDh@OPQf@w@d@k@XKXDFPH\\EbGT`AV`@v@|@NTNb@?XOb@cAxAWLuE@eAFMBoAv@eBt@q@b@}@tAeAt@i@dAC`AFZj@dB?~@[h@MbAVn@b@b@\\d@Eh@Qb@_@d@eB|@c@h@WfBK|AMpA?VF\\\\t@f@t@h@j@|@b@hCb@b@XTd@Bl@GtA?jAL`ALp@Tr@RXd@Rx@Pn@^Zh@Tx@Zf@`@FTCzDy@f@Yx@m@n@Op@VJr@"
/// starred : false

class ExplorerSegment {
  int? id;
  int? resourceState;
  String? name;
  int? climbCategory;
  String? climbCategoryDesc;
  double? avgGrade;
  List<double>? startLatlng;
  List<double>? endLatlng;
  double? elevDifference;
  double? distance;
  String? points;
  bool? starred;

  ExplorerSegment({
      this.id, 
      this.resourceState, 
      this.name, 
      this.climbCategory, 
      this.climbCategoryDesc, 
      this.avgGrade, 
      this.startLatlng, 
      this.endLatlng, 
      this.elevDifference, 
      this.distance, 
      this.points, 
      this.starred});

  ExplorerSegment.fromJson(dynamic json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    climbCategory = json['climb_category'];
    climbCategoryDesc = json['climb_category_desc'];
    avgGrade = json['avg_grade'];
    startLatlng = json['start_latlng'] != null ? json['start_latlng'].cast<double>() : [];
    endLatlng = json['end_latlng'] != null ? json['end_latlng'].cast<double>() : [];
    elevDifference = json['elev_difference'];
    distance = json['distance'];
    points = json['points'];
    starred = json['starred'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['resource_state'] = resourceState;
    map['name'] = name;
    map['climb_category'] = climbCategory;
    map['climb_category_desc'] = climbCategoryDesc;
    map['avg_grade'] = avgGrade;
    map['start_latlng'] = startLatlng;
    map['end_latlng'] = endLatlng;
    map['elev_difference'] = elevDifference;
    map['distance'] = distance;
    map['points'] = points;
    map['starred'] = starred;
    return map;
  }

}