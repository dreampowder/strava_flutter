// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

class Club {
  Club({
    this.fault,
    required this.id,
    required this.resourceState,
    required this.name,
    required this.profileMedium,
    required this.profile,
    required this.coverPhoto,
    required this.coverPhotoSmall,
    required this.sportType,
    required this.city,
    required this.state,
    required this.country,
    required this.private,
    required this.memberCount,
    required this.featured,
    required this.verified,
    required this.url,
    required this.membership,
    required this.admin,
    required this.owner,
    required this.description,
    required this.clubType,
    required this.postCount,
    required this.ownerId,
    required this.followingCount,
  });
  dynamic fault;
  final int id;
  final int resourceState;
  final String name;
  final String profileMedium;
  final String profile;
  final String coverPhoto;
  final String coverPhotoSmall;
  final String sportType;
  final String city;
  final String state;
  final String country;
  final bool private;
  final int memberCount;
  final bool featured;
  final bool verified;
  final String url;
  final String membership;
  final bool admin;
  final bool owner;
  final String description;
  final String clubType;
  final int postCount;
  final int ownerId;
  final int followingCount;

  factory Club.fromRawJson(String str) => Club.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    resourceState: json["resource_state"],
    name: json["name"],
    profileMedium: json["profile_medium"],
    profile: json["profile"],
    coverPhoto: json["cover_photo"],
    coverPhotoSmall: json["cover_photo_small"],
    sportType: json["sport_type"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    private: json["private"],
    memberCount: json["member_count"],
    featured: json["featured"],
    verified: json["verified"],
    url: json["url"],
    membership: json["membership"],
    admin: json["admin"],
    owner: json["owner"],
    description: json["description"],
    clubType: json["club_type"],
    postCount: json["post_count"],
    ownerId: json["owner_id"],
    followingCount: json["following_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resource_state": resourceState,
    "name": name,
    "profile_medium": profileMedium,
    "profile": profile,
    "cover_photo": coverPhoto,
    "cover_photo_small": coverPhotoSmall,
    "sport_type": sportType,
    "city": city,
    "state": state,
    "country": country,
    "private": private,
    "member_count": memberCount,
    "featured": featured,
    "verified": verified,
    "url": url,
    "membership": membership,
    "admin": admin,
    "owner": owner,
    "description": description,
    "club_type": clubType,
    "post_count": postCount,
    "owner_id": ownerId,
    "following_count": followingCount,
  };
}
