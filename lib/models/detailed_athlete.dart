// To parse this JSON data, do
//
//     final detailedAthlete = detailedAthleteFromJson(jsonString);

import 'dart:convert';

class DetailedAthlete {
  DetailedAthlete({
    this.fault,
    required this.id,
    required this.username,
    required this.resourceState,
    required this.firstname,
    required this.lastname,
    required this.city,
    required this.state,
    required this.country,
    required this.sex,
    required this.premium,
    required this.createdAt,
    required this.updatedAt,
    required this.badgeTypeId,
    required this.profileMedium,
    required this.profile,
    required this.friend,
    required this.follower,
    required this.followerCount,
    required this.friendCount,
    required this.mutualFriendCount,
    required this.athleteType,
    required this.datePreference,
    required this.measurementPreference,
    required this.clubs,
    required this.ftp,
    required this.weight,
    required this.bikes,
    required this.shoes,
  });

  dynamic fault;
  final int id;
  final String username;
  final int resourceState;
  final String firstname;
  final String lastname;
  final String city;
  final String state;
  final String country;
  final String sex;
  final bool premium;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int badgeTypeId;
  final String profileMedium;
  final String profile;
  final dynamic friend;
  final dynamic follower;
  final int followerCount;
  final int friendCount;
  final int mutualFriendCount;
  final int athleteType;
  final String datePreference;
  final String measurementPreference;
  final List<dynamic> clubs;
  final dynamic ftp;
  final num weight;
  final List<Bike> bikes;
  final List<Bike> shoes;

  factory DetailedAthlete.fromRawJson(String str) => DetailedAthlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailedAthlete.fromJson(Map<String, dynamic> json) => DetailedAthlete(
    id: json["id"],
    username: json["username"],
    resourceState: json["resource_state"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    sex: json["sex"],
    premium: json["premium"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    badgeTypeId: json["badge_type_id"],
    profileMedium: json["profile_medium"],
    profile: json["profile"],
    friend: json["friend"],
    follower: json["follower"],
    followerCount: json["follower_count"],
    friendCount: json["friend_count"],
    mutualFriendCount: json["mutual_friend_count"],
    athleteType: json["athlete_type"],
    datePreference: json["date_preference"],
    measurementPreference: json["measurement_preference"],
    clubs: List<dynamic>.from(json["clubs"].map((x) => x)),
    ftp: json["ftp"],
    weight: json["weight"],
    bikes: List<Bike>.from(json["bikes"].map((x) => Bike.fromJson(x))),
    shoes: List<Bike>.from(json["shoes"].map((x) => Bike.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "resource_state": resourceState,
    "firstname": firstname,
    "lastname": lastname,
    "city": city,
    "state": state,
    "country": country,
    "sex": sex,
    "premium": premium,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "badge_type_id": badgeTypeId,
    "profile_medium": profileMedium,
    "profile": profile,
    "friend": friend,
    "follower": follower,
    "follower_count": followerCount,
    "friend_count": friendCount,
    "mutual_friend_count": mutualFriendCount,
    "athlete_type": athleteType,
    "date_preference": datePreference,
    "measurement_preference": measurementPreference,
    "clubs": List<dynamic>.from(clubs.map((x) => x)),
    "ftp": ftp,
    "weight": weight,
    "bikes": List<dynamic>.from(bikes.map((x) => x.toJson())),
    "shoes": List<dynamic>.from(shoes.map((x) => x.toJson())),
  };
}

class Bike {
  Bike({
    required this.id,
    required this.primary,
    required this.name,
    required this.resourceState,
    required this.distance,
  });

  final String id;
  final bool primary;
  final String name;
  final int resourceState;
  final int distance;

  factory Bike.fromRawJson(String str) => Bike.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bike.fromJson(Map<String, dynamic> json) => Bike(
    id: json["id"],
    primary: json["primary"],
    name: json["name"],
    resourceState: json["resource_state"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "primary": primary,
    "name": name,
    "resource_state": resourceState,
    "distance": distance,
  };
}
