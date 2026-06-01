import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_summary_club.g.dart';

@JsonSerializable()
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
    this.activityTypes,
  });

  @JsonKey(name: "id")
  int id;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 1 -> `meta`, 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state")
  int resourceState;

  @JsonKey(name: "name")
  String name;

  /// URL to a 60x60 pixel profile picture.
  @JsonKey(name: "profile_medium")
  String? profileMedium;

  @JsonKey(name: "profile")
  String? profile;

  /// URL to a ~1185x580 pixel cover photo.
  @JsonKey(name: "cover_photo")
  String? coverPhoto;

  /// URL to a ~360x176 pixel cover photo.
  @JsonKey(name: "cover_photo_small")
  String? coverPhotoSmall;

  @JsonKey(name: "sport_type")
  String? sportType;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "private")
  bool private;

  @JsonKey(name: "member_count")
  int memberCount;

  @JsonKey(name: "featured")
  bool featured;

  @JsonKey(name: "verified")
  bool verified;

  @JsonKey(name: "url")
  String? url;

  /// The activity types that count for a club. This takes precedence over
  /// [sportType]. Values such as `Ride`, `Run`, etc.
  @JsonKey(name: "activity_types")
  List<String>? activityTypes;

  factory SummaryClub.fromRawJson(String str) =>
      SummaryClub.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryClub.fromJson(Map<String, dynamic> json) =>
      _$SummaryClubFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryClubToJson(this);
}
