import 'dart:convert';

class SummaryClub {
  SummaryClub({
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
  });

  int id;
  int resourceState;
  String name;
  String? profileMedium;
  String? profile;
  String? coverPhoto;
  String? coverPhotoSmall;
  String? sportType;
  String? city;
  String? state;
  String? country;
  bool private;
  int memberCount;
  bool featured;
  bool verified;
  String? url;

  factory SummaryClub.fromRawJson(String str) => SummaryClub.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryClub.fromJson(Map<String, dynamic> json) => SummaryClub(
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
  };
}
