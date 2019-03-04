// Detailed athlete

import '../API/constants.dart';
import 'fault.dart';

// NOT working yet, problem with club
import 'club.dart';

class DetailedAthlete {
  Fault fault;
  int id;
  String username;
  int resourceState;
  String firstname;
  String lastname;
  String city;
  String state;
  String country;
  String sex;
  bool premium;
  String createdAt;
  String updatedAt;
  int badgeTypeId;
  String profileMedium;
  String profile;
  String friend;
  String follower;
  int followerCount;
  int friendCount;
  int mutualFriendCount;
  int athleteType;
  String datePreference;
  String measurementPreference;
  // List<Null> clubs;
  int ftp;
  double weight;
  List<Bikes> bikes;
  List<Shoes> shoes;

  DetailedAthlete (
      {Fault fault,
      this.id,
      this.username,
      this.resourceState,
      this.firstname,
      this.lastname,
      this.city,
      this.state,
      this.country,
      this.sex,
      this.premium,
      this.createdAt,
      this.updatedAt,
      this.badgeTypeId,
      this.profileMedium,
      this.profile,
      this.friend,
      this.follower,
      this.followerCount,
      this.friendCount,
      this.mutualFriendCount,
      this.athleteType,
      this.datePreference,
      this.measurementPreference,
      // this.clubs,
      this.ftp,
      this.weight,
      this.bikes,
      this.shoes}): fault = Fault(99, '');

  DetailedAthlete .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    resourceState = json['resource_state'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    sex = json['sex'];
    premium = json['premium'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    badgeTypeId = json['badge_type_id'];
    profileMedium = json['profile_medium'];
    profile = json['profile'];
    friend = json['friend'];
    follower = json['follower'];
    followerCount = json['follower_count'];
    friendCount = json['friend_count'];
    mutualFriendCount = json['mutual_friend_count'];
    athleteType = json['athlete_type'];
    datePreference = json['date_preference'];
    measurementPreference = json['measurement_preference'];
    /**** 
    if (json['clubs'] != null) {
      clubs = List<Club>();
      json['clubs'].forEach((v) {
        clubs.add(Club.fromJson(v));
      });
    }
  ***/
    ftp = json['ftp'];
    weight = json['weight'];
    if (json['bikes'] != null) {
      bikes =  List<Bikes>();
      json['bikes'].forEach((v) {
        bikes.add(Bikes.fromJson(v));
      });
    }
    if (json['shoes'] != null) {
      shoes = List<Shoes>();
      json['shoes'].forEach((v) {
        shoes.add(Shoes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['resource_state'] = this.resourceState;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['sex'] = this.sex;
    data['premium'] = this.premium;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['badge_type_id'] = this.badgeTypeId;
    data['profile_medium'] = this.profileMedium;
    data['profile'] = this.profile;
    data['friend'] = this.friend;
    data['follower'] = this.follower;
    data['follower_count'] = this.followerCount;
    data['friend_count'] = this.friendCount;
    data['mutual_friend_count'] = this.mutualFriendCount;
    data['athlete_type'] = this.athleteType;
    data['date_preference'] = this.datePreference;
    data['measurement_preference'] = this.measurementPreference;
    /***
    if (this.clubs != null) {
      data['clubs'] = this.clubs.map((v) => v.toJson()).toList();
    }
  ***/
    data['ftp'] = this.ftp;
    data['weight'] = this.weight;
    if (this.bikes != null) {
      data['bikes'] = this.bikes.map((v) => v.toJson()).toList();
    }
    if (this.shoes != null) {
      data['shoes'] = this.shoes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bikes {
  String id;
  bool primary;
  String name;
  int resourceState;
  int distance;

  Bikes({this.id, this.primary, this.name, this.resourceState, this.distance});

  Bikes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    primary = json['primary'];
    name = json['name'];
    resourceState = json['resource_state'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['primary'] = this.primary;
    data['name'] = this.name;
    data['resource_state'] = this.resourceState;
    data['distance'] = this.distance;
    return data;
  }
}

class Shoes {
  String id;
  bool primary;
  String name;
  int resourceState;
  int distance;

  Shoes({this.id, this.primary, this.name, this.resourceState, this.distance});

  Shoes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    primary = json['primary'];
    name = json['name'];
    resourceState = json['resource_state'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['primary'] = this.primary;
    data['name'] = this.name;
    data['resource_state'] = this.resourceState;
    data['distance'] = this.distance;
    return data;
  }
}
