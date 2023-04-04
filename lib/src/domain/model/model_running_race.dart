// country : "aeiou"
// route_ids : [5]
// running_race_type : 6
// distance : 1.4658129
// website_url : "aeiou"
// city : "aeiou"
// start_date_local : "2000-01-23T04:56:07.000+00:00"
// name : "aeiou"
// measurement_preference : "feet"
// id : 0
// state : "aeiou"
// url : "aeiou"
class RunningRace {
  String? country;
  List<int>? routeIds;
  int? runningRaceType;
  double? distance;
  String? websiteUrl;
  String? city;
  String? startDateLocal;
  String? name;
  String? measurementPreference;
  int? id;
  String? state;
  String? url;

  RunningRace(
      {this.country,
      this.routeIds,
      this.runningRaceType,
      this.distance,
      this.websiteUrl,
      this.city,
      this.startDateLocal,
      this.name,
      this.measurementPreference,
      this.id,
      this.state,
      this.url});

  RunningRace.fromJson(dynamic json) {
    country = json['country'];
    routeIds = json['route_ids'] != null ? json['route_ids'].cast<int>() : [];
    runningRaceType = json['running_race_type'];
    distance = json['distance'];
    websiteUrl = json['website_url'];
    city = json['city'];
    startDateLocal = json['start_date_local'];
    name = json['name'];
    measurementPreference = json['measurement_preference'];
    id = json['id'];
    state = json['state'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['country'] = country;
    map['route_ids'] = routeIds;
    map['running_race_type'] = runningRaceType;
    map['distance'] = distance;
    map['website_url'] = websiteUrl;
    map['city'] = city;
    map['start_date_local'] = startDateLocal;
    map['name'] = name;
    map['measurement_preference'] = measurementPreference;
    map['id'] = id;
    map['state'] = state;
    map['url'] = url;
    return map;
  }
}
