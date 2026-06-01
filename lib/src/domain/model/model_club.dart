// Example of value :
//
// id : 1
// resource_state : 3
// name : "Team Strava Cycling"
// profile_medium : "https://dgalywyr863hv.cloudfront.net/pictures/clubs/1/1582/4/medium.jpg"
// profile : "https://dgalywyr863hv.cloudfront.net/pictures/clubs/1/1582/4/large.jpg"
// cover_photo : "https://dgalywyr863hv.cloudfront.net/pictures/clubs/1/4328276/1/large.jpg"
// cover_photo_small : "https://dgalywyr863hv.cloudfront.net/pictures/clubs/1/4328276/1/small.jpg"
// sport_type : "cycling"
// city : "San Francisco"
// state : "California"
// country : "United States"
// private : true
// member_count : 116
// featured : false
// verified : false
// url : "team-strava-bike"
// membership : "member"
// admin : false
// owner : false
// description : "Private club for Cyclists who work at Strava."
// club_type : "company"
// post_count : 29
// owner_id : 759
// following_count : 107
import 'package:json_annotation/json_annotation.dart';

part 'model_club.g.dart';

@JsonSerializable()
class Club {
  @JsonKey(name: "id")
  int? id;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 1 -> `meta`, 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state")
  int? resourceState;

  @JsonKey(name: "name")
  String? name;

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

  /// Deprecated. Prefer to use `activity_types`.
  ///
  /// May take one of the following values: `cycling`, `running`, `triathlon`,
  /// `other`.
  @JsonKey(name: "sport_type")
  String? sportType;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "private")
  bool? private;

  @JsonKey(name: "member_count")
  int? memberCount;

  @JsonKey(name: "featured")
  bool? featured;

  @JsonKey(name: "verified")
  bool? verified;

  /// The club's vanity URL.
  @JsonKey(name: "url")
  String? url;

  /// The membership status of the logged-in athlete.
  ///
  /// May take one of the following values: `member`, `pending`.
  @JsonKey(name: "membership")
  String? membership;

  @JsonKey(name: "admin")
  bool? admin;

  @JsonKey(name: "owner")
  bool? owner;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "club_type")
  String? clubType;

  @JsonKey(name: "post_count")
  int? postCount;

  @JsonKey(name: "owner_id")
  int? ownerId;

  @JsonKey(name: "following_count")
  int? followingCount;

  Club({
    this.id,
    this.resourceState,
    this.name,
    this.profileMedium,
    this.profile,
    this.coverPhoto,
    this.coverPhotoSmall,
    this.sportType,
    this.city,
    this.state,
    this.country,
    this.private,
    this.memberCount,
    this.featured,
    this.verified,
    this.url,
    this.membership,
    this.admin,
    this.owner,
    this.description,
    this.clubType,
    this.postCount,
    this.ownerId,
    this.followingCount,
  });

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}
