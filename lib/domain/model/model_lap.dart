class Lap {
  int? id;
  int? resourceState;
  String? name;
  MetaActivity? activity;
  MetaAthlete? athlete;
  int? elapsedTime;
  int? movingTime;
  String? startDate;
  String? startDateLocal;
  double? distance;
  int? startIndex;
  int? endIndex;
  double? totalElevationGain;
  double? averageSpeed;
  double? maxSpeed;
  double? averageCadence;
  bool? deviceWatts;
  double? averageWatts;
  int? lapIndex;
  int? split;

  Lap(
      {this.id,
      this.resourceState,
      this.name,
      this.activity,
      this.athlete,
      this.elapsedTime,
      this.movingTime,
      this.startDate,
      this.startDateLocal,
      this.distance,
      this.startIndex,
      this.endIndex,
      this.totalElevationGain,
      this.averageSpeed,
      this.maxSpeed,
      this.averageCadence,
      this.deviceWatts,
      this.averageWatts,
      this.lapIndex,
      this.split});

  Lap.fromJson(dynamic json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    activity = json['activity'] != null
        ? MetaActivity.fromJson(json['activity'])
        : null;
    athlete =
        json['athlete'] != null ? MetaAthlete.fromJson(json['athlete']) : null;
    elapsedTime = json['elapsed_time'];
    movingTime = json['moving_time'];
    startDate = json['start_date'];
    startDateLocal = json['start_date_local'];
    distance = json['distance'];
    startIndex = json['start_index'];
    endIndex = json['end_index'];
    totalElevationGain = json['total_elevation_gain'];
    averageSpeed = json['average_speed'];
    maxSpeed = json['max_speed'];
    averageCadence = json['average_cadence'];
    deviceWatts = json['device_watts'];
    averageWatts = json['average_watts'];
    lapIndex = json['lap_index'];
    split = json['split'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['resource_state'] = resourceState;
    map['name'] = name;
    if (activity != null) {
      map['activity'] = activity?.toJson();
    }
    if (athlete != null) {
      map['athlete'] = athlete?.toJson();
    }
    map['elapsed_time'] = elapsedTime;
    map['moving_time'] = movingTime;
    map['start_date'] = startDate;
    map['start_date_local'] = startDateLocal;
    map['distance'] = distance;
    map['start_index'] = startIndex;
    map['end_index'] = endIndex;
    map['total_elevation_gain'] = totalElevationGain;
    map['average_speed'] = averageSpeed;
    map['max_speed'] = maxSpeed;
    map['average_cadence'] = averageCadence;
    map['device_watts'] = deviceWatts;
    map['average_watts'] = averageWatts;
    map['lap_index'] = lapIndex;
    map['split'] = split;
    return map;
  }
}

/// id : 134815
/// resource_state : 1

class MetaAthlete {
  int? id;
  int? resourceState;

  MetaAthlete({this.id, this.resourceState});

  MetaAthlete.fromJson(dynamic json) {
    id = json['id'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['resource_state'] = resourceState;
    return map;
  }
}

/// id : 1410355832
/// resource_state : 1

class MetaActivity {
  int? id;
  int? resourceState;

  MetaActivity({this.id, this.resourceState});

  MetaActivity.fromJson(dynamic json) {
    id = json['id'];
    resourceState = json['resource_state'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['resource_state'] = resourceState;
    return map;
  }
}
