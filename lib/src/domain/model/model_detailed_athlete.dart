// To parse this JSON data, do
//
//     final detailedAthlete = detailedAthleteFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:strava_client/src/domain/model/model_summary_club.dart';
import 'package:strava_client/src/domain/model/model_summary_gear.dart';

class DetailedAthlete {
  DetailedAthlete(
      {required this.id,
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
      this.bio});

  int id;
  String? username;
  int resourceState;
  String firstname;
  String lastname;
  String city;
  String state;
  String country;
  String sex;
  String? bio;
  bool premium;
  DateTime? createdAt;
  DateTime? updatedAt;
  int badgeTypeId;
  String? profileMedium;
  String? profile;
  dynamic friend;
  dynamic follower;
  int followerCount;
  int friendCount;
  int mutualFriendCount;
  int athleteType;
  String datePreference;
  String measurementPreference;
  List<SummaryClub> clubs;
  int? ftp;
  num? weight;
  List<SummaryGear> bikes;
  List<SummaryGear> shoes;

  factory DetailedAthlete.fromRawJson(String str) =>
      DetailedAthlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailedAthlete.fromJson(Map<String, dynamic> json) {
    var summaryClubJson =
        json["clubs"]; //Added here to catch a mapping exception
    List<SummaryClub> clubs = [];
    if (summaryClubJson is List) {
      try {
        clubs = summaryClubJson.map((e) => SummaryClub.fromJson(e)).toList();
      } catch (exception, stackTrace) {
        clubs = [];
        debugPrint("Exception: $exception");
        debugPrintStack(
            stackTrace: stackTrace,
            label: "An error occurred while serializing summary club json");
      }
    }
    return DetailedAthlete(
        id: json["id"],
        username: json["username"] ?? "",
        resourceState: json["resource_state"] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        sex: json["sex"] ?? "",
        premium: json["premium"] ?? false,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        badgeTypeId: json["badge_type_id"],
        profileMedium: json["profile_medium"],
        profile: json["profile"],
        friend: json["friend"],
        follower: json["follower"],
        followerCount: json["follower_count"] ?? 0,
        friendCount: json["friend_count"] ?? 0,
        mutualFriendCount: json["mutual_friend_count"] ?? 0,
        athleteType: json["athlete_type"] ?? 0,
        datePreference: json["date_preference"] ?? "",
        measurementPreference: json["measurement_preference"] ?? "",
        clubs: clubs,
        ftp: json["ftp"],
        weight: json["weight"],
        bikes: json["bikes"] == null
            ? <SummaryGear>[]
            : List<SummaryGear>.from(
                json["bikes"].map((x) => SummaryGear.fromJson(x))),
        shoes: json["shoes"] == null
            ? <SummaryGear>[]
            : List<SummaryGear>.from(
                json["shoes"].map((x) => SummaryGear.fromJson(x))),
        bio: json["bio"]);
  }

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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        "clubs": List<dynamic>.from(clubs.map((x) => x.toJson())),
        "ftp": ftp,
        "weight": weight,
        "bikes": List<dynamic>.from(bikes.map((x) => x.toJson())),
        "shoes": List<dynamic>.from(shoes.map((x) => x.toJson())),
        "bio": bio
      };
}
