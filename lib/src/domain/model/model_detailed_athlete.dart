// To parse this JSON data, do
//
//     final detailedAthlete = detailedAthleteFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:strava_client/src/domain/model/model_summary_club.dart';
import 'package:strava_client/src/domain/model/model_summary_gear.dart';

part 'model_detailed_athlete.g.dart';

/// Preserves the legacy behavior of accepting a non-`int` fallback (`""`) when
/// the `resource_state` field is absent from the JSON payload.
dynamic _resourceStateFromJson(dynamic value) => value ?? "";

/// Preserves the legacy behavior of catching deserialization errors for the
/// `clubs` list and returning an empty list (not null) on failure or when the
/// field is absent / not a list.
List<SummaryClub> _clubsFromJson(dynamic value) {
  List<SummaryClub> clubs = [];
  if (value is List) {
    try {
      clubs = value.map((e) => SummaryClub.fromJson(e)).toList();
    } catch (exception, stackTrace) {
      clubs = [];
      debugPrint("Exception: $exception");
      debugPrintStack(
          stackTrace: stackTrace,
          label: "An error occurred while serializing summary club json");
    }
  }
  return clubs;
}

/// Preserves the legacy behavior of returning an empty list (not null) when a
/// gear field (`bikes` / `shoes`) is absent from the JSON payload.
List<SummaryGear> _gearFromJson(dynamic value) => value == null
    ? <SummaryGear>[]
    : List<SummaryGear>.from(
        value.map((x) => SummaryGear.fromJson(x)));

@JsonSerializable()
class DetailedAthlete {
  DetailedAthlete(
      {required this.id,
      required this.username,
      required this.resourceState,
      required this.firstname,
      required this.lastname,
      required this.city,
      required this.state,
      required this.country,
      required this.sex,
      required this.premium,
      required this.createdAt,
      required this.updatedAt,
      required this.badgeTypeId,
      required this.profileMedium,
      required this.profile,
      required this.friend,
      required this.follower,
      required this.followerCount,
      required this.friendCount,
      required this.mutualFriendCount,
      required this.athleteType,
      required this.datePreference,
      required this.measurementPreference,
      required this.clubs,
      required this.ftp,
      required this.weight,
      required this.bikes,
      required this.shoes,
      this.bio});

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "username", defaultValue: "")
  String? username;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 1 -> `meta`, 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state", fromJson: _resourceStateFromJson)
  int resourceState;

  @JsonKey(name: "firstname", defaultValue: "")
  String firstname;

  @JsonKey(name: "lastname", defaultValue: "")
  String lastname;

  @JsonKey(name: "city", defaultValue: "")
  String city;

  @JsonKey(name: "state", defaultValue: "")
  String state;

  @JsonKey(name: "country", defaultValue: "")
  String country;

  /// The athlete's sex. May take one of the following values: `M`, `F`.
  @JsonKey(name: "sex", defaultValue: "")
  String sex;

  @JsonKey(name: "premium", defaultValue: false)
  bool premium;

  @JsonKey(name: "created_at")
  DateTime? createdAt;

  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  @JsonKey(name: "badge_type_id")
  int badgeTypeId;

  /// URL to a 62x62 pixel profile picture.
  @JsonKey(name: "profile_medium")
  String? profileMedium;

  /// URL to a 124x124 pixel profile picture.
  @JsonKey(name: "profile")
  String? profile;

  @JsonKey(name: "friend")
  dynamic friend;

  @JsonKey(name: "follower")
  dynamic follower;

  @JsonKey(name: "follower_count", defaultValue: 0)
  int followerCount;

  @JsonKey(name: "friend_count", defaultValue: 0)
  int friendCount;

  @JsonKey(name: "mutual_friend_count", defaultValue: 0)
  int mutualFriendCount;

  @JsonKey(name: "athlete_type", defaultValue: 0)
  int athleteType;

  @JsonKey(name: "date_preference", defaultValue: "")
  String datePreference;

  /// The athlete's preferred unit system.
  ///
  /// May take one of the following values: `feet`, `meters`.
  @JsonKey(name: "measurement_preference", defaultValue: "")
  String measurementPreference;

  @JsonKey(name: "clubs", fromJson: _clubsFromJson)
  List<SummaryClub> clubs;

  @JsonKey(name: "ftp")
  int? ftp;

  @JsonKey(name: "weight")
  num? weight;

  @JsonKey(name: "bikes", fromJson: _gearFromJson)
  List<SummaryGear> bikes;

  @JsonKey(name: "shoes", fromJson: _gearFromJson)
  List<SummaryGear> shoes;

  @JsonKey(name: "bio")
  String? bio;

  factory DetailedAthlete.fromRawJson(String str) =>
      DetailedAthlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailedAthlete.fromJson(Map<String, dynamic> json) =>
      _$DetailedAthleteFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedAthleteToJson(this);
}
