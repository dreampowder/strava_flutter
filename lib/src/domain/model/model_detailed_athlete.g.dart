// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_detailed_athlete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedAthlete _$DetailedAthleteFromJson(Map<String, dynamic> json) =>
    DetailedAthlete(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String? ?? '',
      resourceState: _resourceStateFromJson(json['resource_state']),
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
      premium: json['premium'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      badgeTypeId: (json['badge_type_id'] as num).toInt(),
      profileMedium: json['profile_medium'] as String?,
      profile: json['profile'] as String?,
      friend: json['friend'],
      follower: json['follower'],
      followerCount: (json['follower_count'] as num?)?.toInt() ?? 0,
      friendCount: (json['friend_count'] as num?)?.toInt() ?? 0,
      mutualFriendCount: (json['mutual_friend_count'] as num?)?.toInt() ?? 0,
      athleteType: (json['athlete_type'] as num?)?.toInt() ?? 0,
      datePreference: json['date_preference'] as String? ?? '',
      measurementPreference: json['measurement_preference'] as String? ?? '',
      clubs: _clubsFromJson(json['clubs']),
      ftp: (json['ftp'] as num?)?.toInt(),
      weight: json['weight'] as num?,
      bikes: _gearFromJson(json['bikes']),
      shoes: _gearFromJson(json['shoes']),
      bio: json['bio'] as String?,
      summit: json['summit'] as bool?,
    );

Map<String, dynamic> _$DetailedAthleteToJson(DetailedAthlete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'resource_state': instance.resourceState,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'sex': instance.sex,
      'premium': instance.premium,
      'summit': instance.summit,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'badge_type_id': instance.badgeTypeId,
      'profile_medium': instance.profileMedium,
      'profile': instance.profile,
      'friend': instance.friend,
      'follower': instance.follower,
      'follower_count': instance.followerCount,
      'friend_count': instance.friendCount,
      'mutual_friend_count': instance.mutualFriendCount,
      'athlete_type': instance.athleteType,
      'date_preference': instance.datePreference,
      'measurement_preference': instance.measurementPreference,
      'clubs': instance.clubs.map((e) => e.toJson()).toList(),
      'ftp': instance.ftp,
      'weight': instance.weight,
      'bikes': instance.bikes.map((e) => e.toJson()).toList(),
      'shoes': instance.shoes.map((e) => e.toJson()).toList(),
      'bio': instance.bio,
    };
