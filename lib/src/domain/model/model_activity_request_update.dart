import 'package:strava_client/src/domain/model/model_activity_type_enum.dart';

/// Model containing information to update an `Activity` on *Strava*.
class UpdateActivityRequest {
  String? name;
  ActivityTypeEnum? type;
  String? description;
  bool? isTrainerActivity;
  bool? isCommuteActivity;
  String? gearId;
  bool? hideFromHome;

  UpdateActivityRequest({
    this.name,
    this.type,
    this.description,
    this.isTrainerActivity,
    this.isCommuteActivity,
    this.gearId,
    this.hideFromHome,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) "name": name,
        if (description != null) "description": description,
        if (type != null) "type": type!.stringValue(),
        if (isTrainerActivity != null) "trainer": isTrainerActivity! ? 1 : 0,
        if (isCommuteActivity != null) "commute": isCommuteActivity! ? 1 : 0,
        if (gearId != null) "gear_id": gearId,
        if (hideFromHome != null) "hide_from_home": hideFromHome! ? 1 : 0,
      };
}
