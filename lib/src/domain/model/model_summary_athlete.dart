import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_summary_athlete.g.dart';

@JsonSerializable()
class SummaryAthlete {
  SummaryAthlete({
    required this.id,
    required this.resourceState,
    required this.firstname,
    required this.lastname,
    required this.profileMedium,
    required this.profile,
    required this.city,
    required this.state,
    required this.country,
    required this.sex,
    required this.premium,
    required this.summit,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: "id")
  int id;

  /// Resource state, indicates level of detail.
  ///
  /// Possible values: 1 -> `meta`, 2 -> `summary`, 3 -> `detail`.
  @JsonKey(name: "resource_state")
  int resourceState;

  @JsonKey(name: "firstname")
  String firstname;

  @JsonKey(name: "lastname")
  String lastname;

  /// URL to a 62x62 pixel profile picture.
  @JsonKey(name: "profile_medium")
  String profileMedium;

  /// URL to a 124x124 pixel profile picture.
  @JsonKey(name: "profile")
  String profile;

  @JsonKey(name: "city")
  String city;

  @JsonKey(name: "state")
  String state;

  @JsonKey(name: "country")
  String country;

  /// The athlete's sex. May take one of the following values: `M`, `F`.
  @JsonKey(name: "sex")
  String sex;

  @JsonKey(name: "premium")
  bool premium;

  @JsonKey(name: "summit")
  bool summit;

  @JsonKey(name: "created_at")
  String createdAt;

  @JsonKey(name: "updated_at")
  String updatedAt;

  factory SummaryAthlete.fromRawJson(String str) =>
      SummaryAthlete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryAthlete.fromJson(Map<String, dynamic> json) =>
      _$SummaryAthleteFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryAthleteToJson(this);
}
