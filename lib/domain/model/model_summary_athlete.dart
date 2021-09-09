// To parse this JSON data, do
//
//     final summaryAthlete = summaryAthleteFromJson(jsonString);

import 'dart:convert';

class SummaryAthlete {
  SummaryAthlete({
    required this.id,
    required this.resourceState,
    required this.firstname,
    required this.lastname,
    required this.profileMedium,
    required this.profile,
    required this.city,
    required this.state,
    required this.country,
    required this.sex,
    required this.premium,
    required this.summit,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int resourceState;
  String firstname;
  String lastname;
  String profileMedium;
  String profile;
  String city;
  String state;
  String country;
  String sex;
  bool premium;
  bool summit;
  String createdAt;
  String updatedAt;

  factory SummaryAthlete.fromRawJson(String str) => SummaryAthlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryAthlete.fromJson(Map<String, dynamic> json) => SummaryAthlete(
    id: json["id"],
    resourceState: json["resource_state"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    profileMedium: json["profile_medium"],
    profile: json["profile"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    sex: json["sex"],
    premium: json["premium"],
    summit: json["summit"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resource_state": resourceState,
    "firstname": firstname,
    "lastname": lastname,
    "profile_medium": profileMedium,
    "profile": profile,
    "city": city,
    "state": state,
    "country": country,
    "sex": sex,
    "premium": premium,
    "summit": summit,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
