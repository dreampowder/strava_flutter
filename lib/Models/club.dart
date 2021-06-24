// Club

import 'fault.dart';

class Club {
  Fault? fault;
  int? id;
  int? resourceState;
  String? name;
  String? profileMedium;
  String? profile;
  String? coverPhoto;
  String? coverPhotoSmall;
  String? sportType;
  String? city;
  String? state;
  String? country;
  bool? private;
  int? memberCount;
  bool? featured;
  bool? verified;
  String? url;
  String? membership;
  bool? admin;
  bool? owner;
  String? description;
  String? clubType;
  int? postCount;
  int? ownerId;
  int? followingCount;

  Club(
      {Fault? fault,
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
      this.followingCount})
      : fault = Fault(88, '');

  Club.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceState = json['resource_state'];
    name = json['name'];
    profileMedium = json['profile_medium'];
    profile = json['profile'];
    coverPhoto = json['cover_photo'];
    coverPhotoSmall = json['cover_photo_small'];
    sportType = json['sport_type'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    private = json['private'];
    memberCount = json['member_count'];
    featured = json['featured'];
    verified = json['verified'];
    url = json['url'];
    membership = json['membership'];
    admin = json['admin'];
    owner = json['owner'];
    description = json['description'];
    clubType = json['club_type'];
    postCount = json['post_count'];
    ownerId = json['owner_id'];
    followingCount = json['following_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['resource_state'] = this.resourceState;
    data['name'] = this.name;
    data['profile_medium'] = this.profileMedium;
    data['profile'] = this.profile;
    data['cover_photo'] = this.coverPhoto;
    data['cover_photo_small'] = this.coverPhotoSmall;
    data['sport_type'] = this.sportType;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['private'] = this.private;
    data['member_count'] = this.memberCount;
    data['featured'] = this.featured;
    data['verified'] = this.verified;
    data['url'] = this.url;
    data['membership'] = this.membership;
    data['admin'] = this.admin;
    data['owner'] = this.owner;
    data['description'] = this.description;
    data['club_type'] = this.clubType;
    data['post_count'] = this.postCount;
    data['owner_id'] = this.ownerId;
    data['following_count'] = this.followingCount;
    return data;
  }
}
