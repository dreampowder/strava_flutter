// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
  id: (json['id'] as num?)?.toInt(),
  resourceState: (json['resource_state'] as num?)?.toInt(),
  name: json['name'] as String?,
  profileMedium: json['profile_medium'] as String?,
  profile: json['profile'] as String?,
  coverPhoto: json['cover_photo'] as String?,
  coverPhotoSmall: json['cover_photo_small'] as String?,
  sportType: json['sport_type'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  private: json['private'] as bool?,
  memberCount: (json['member_count'] as num?)?.toInt(),
  featured: json['featured'] as bool?,
  verified: json['verified'] as bool?,
  url: json['url'] as String?,
  membership: json['membership'] as String?,
  admin: json['admin'] as bool?,
  owner: json['owner'] as bool?,
  description: json['description'] as String?,
  clubType: json['club_type'] as String?,
  postCount: (json['post_count'] as num?)?.toInt(),
  ownerId: (json['owner_id'] as num?)?.toInt(),
  followingCount: (json['following_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
  'id': instance.id,
  'resource_state': instance.resourceState,
  'name': instance.name,
  'profile_medium': instance.profileMedium,
  'profile': instance.profile,
  'cover_photo': instance.coverPhoto,
  'cover_photo_small': instance.coverPhotoSmall,
  'sport_type': instance.sportType,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'private': instance.private,
  'member_count': instance.memberCount,
  'featured': instance.featured,
  'verified': instance.verified,
  'url': instance.url,
  'membership': instance.membership,
  'admin': instance.admin,
  'owner': instance.owner,
  'description': instance.description,
  'club_type': instance.clubType,
  'post_count': instance.postCount,
  'owner_id': instance.ownerId,
  'following_count': instance.followingCount,
};
