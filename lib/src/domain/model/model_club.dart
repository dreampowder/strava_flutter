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
class Club {
  int? id;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 1 -> `meta`, 2 -> `summary`, 3 -> `detail`.
  int? resourceState;
  String? name;

  /// URL to a 60x60 pixel profile picture.
  String? profileMedium;
  String? profile;

  /// URL to a ~1185x580 pixel cover photo.
  String? coverPhoto;

  /// URL to a ~360x176 pixel cover photo.
  String? coverPhotoSmall;

  /// Deprecated. Prefer to use `activity_types`.
  ///
  /// May take one of the following values: `cycling`, `running`, `triathlon`,
  /// `other`.
  String? sportType;
  String? city;
  String? state;
  String? country;
  bool? private;
  int? memberCount;
  bool? featured;
  bool? verified;

  /// The club's vanity URL.
  String? url;

  /// The membership status of the logged-in athlete.
  ///
  /// May take one of the following values: `member`, `pending`.
  String? membership;
  bool? admin;
  bool? owner;
  String? description;
  String? clubType;
  int? postCount;
  int? ownerId;
  int? followingCount;

  Club(
      {this.id,
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
      this.followingCount});

  Club.fromJson(dynamic json) {
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
    var map = <String, dynamic>{};
    map['id'] = id;
    map['resource_state'] = resourceState;
    map['name'] = name;
    map['profile_medium'] = profileMedium;
    map['profile'] = profile;
    map['cover_photo'] = coverPhoto;
    map['cover_photo_small'] = coverPhotoSmall;
    map['sport_type'] = sportType;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['private'] = private;
    map['member_count'] = memberCount;
    map['featured'] = featured;
    map['verified'] = verified;
    map['url'] = url;
    map['membership'] = membership;
    map['admin'] = admin;
    map['owner'] = owner;
    map['description'] = description;
    map['club_type'] = clubType;
    map['post_count'] = postCount;
    map['owner_id'] = ownerId;
    map['following_count'] = followingCount;
    return map;
  }
}
