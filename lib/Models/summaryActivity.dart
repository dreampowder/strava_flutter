// Summary Activity

class SummaryActivity {
  int id;
  int resourceState;
  Athlete athlete;
  String name;
  double distance;
  int movingTime;
  int elapsedTime;
  double totalElevationGain;
  String type;
  int workoutType;

  SummaryActivity(
      {this.id,
      this.resourceState,
      this.athlete,
      this.name,
      this.distance,
      this.movingTime,
      this.elapsedTime,
      this.totalElevationGain,
      this.type,
      this.workoutType});

  SummaryActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    athlete =
        json['athlete'] != null ? Athlete.fromJson(json['athlete']) : null;
    name = json['name'];
    distance = json['distance'];
    movingTime = json['moving_time'];
    elapsedTime = json['elapsed_time'];
    totalElevationGain = json['total_elevation_gain'];
    type = json['type'];
    workoutType = json['workout_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    if (this.athlete != null) {
      data['athlete'] = this.athlete.toJson();
    }
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['moving_time'] = this.movingTime;
    data['elapsed_time'] = this.elapsedTime;
    data['total_elevation_gain'] = this.totalElevationGain;
    data['type'] = this.type;
    data['workout_type'] = this.workoutType;
    return data;
  }
}

class Athlete {
  int resourceState;
  String firstname;
  String lastname;

  Athlete({this.resourceState, this.firstname, this.lastname});

  Athlete.fromJson(Map<String, dynamic> json) {
    resourceState = json['resource_state'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resource_state'] = this.resourceState;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}

