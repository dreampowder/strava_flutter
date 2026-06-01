import 'package:json_annotation/json_annotation.dart';

part 'model_running_race.g.dart';

/// Preserves the legacy behavior of returning an empty list (not null) when
/// the route_ids field is absent from the JSON payload.
List<int>? _routeIdsFromJson(dynamic value) =>
    value != null ? (value as List).cast<int>() : <int>[];

// country : "aeiou"
// route_ids : [5]
// running_race_type : 6
// distance : 1.4658129
// website_url : "aeiou"
// city : "aeiou"
// start_date_local : "2000-01-23T04:56:07.000+00:00"
// name : "aeiou"
// measurement_preference : "feet"
// id : 0
// state : "aeiou"
// url : "aeiou"
@JsonSerializable()
class RunningRace {
  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "route_ids", fromJson: _routeIdsFromJson)
  List<int>? routeIds;

  @JsonKey(name: "running_race_type")
  int? runningRaceType;

  @JsonKey(name: "distance")
  double? distance;

  @JsonKey(name: "website_url")
  String? websiteUrl;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "start_date_local")
  String? startDateLocal;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "measurement_preference")
  String? measurementPreference;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "url")
  String? url;

  RunningRace(
      {this.country,
      this.routeIds,
      this.runningRaceType,
      this.distance,
      this.websiteUrl,
      this.city,
      this.startDateLocal,
      this.name,
      this.measurementPreference,
      this.id,
      this.state,
      this.url});

  factory RunningRace.fromJson(Map<String, dynamic> json) =>
      _$RunningRaceFromJson(json);

  Map<String, dynamic> toJson() => _$RunningRaceToJson(this);
}
