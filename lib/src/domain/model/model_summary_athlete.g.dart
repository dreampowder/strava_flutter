// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_summary_athlete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryAthlete _$SummaryAthleteFromJson(Map<String, dynamic> json) =>
    SummaryAthlete(
      id: (json['id'] as num).toInt(),
      resourceState: (json['resource_state'] as num).toInt(),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      profileMedium: json['profile_medium'] as String,
      profile: json['profile'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      sex: json['sex'] as String,
      premium: json['premium'] as bool,
      summit: json['summit'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$SummaryAthleteToJson(SummaryAthlete instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_state': instance.resourceState,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'profile_medium': instance.profileMedium,
      'profile': instance.profile,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'sex': instance.sex,
      'premium': instance.premium,
      'summit': instance.summit,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
