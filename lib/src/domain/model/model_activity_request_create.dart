import 'package:strava_client/src/domain/model/model_activity_type_enum.dart';

/// Model containing information to create a manual `Activity` on *Strava*.
class CreateActivityRequest {
  String name;
  ActivityTypeEnum type;
  DateTime startDateLocal;
  int elapsedTimeInSeconds;
  String description;
  double distanceInMeters;
  bool isTrainerActivity;
  bool isCommuteActivity;

  CreateActivityRequest(
      this.name,
      this.type,
      this.startDateLocal,
      this.elapsedTimeInSeconds,
      this.description,
      this.distanceInMeters,
      this.isTrainerActivity,
      this.isCommuteActivity);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "type": type.stringValue(),
        "start_date_local": startDateLocal.toIso8601String(),
        "elapsed_time": elapsedTimeInSeconds,
        "distance": distanceInMeters,
        "trainer": isTrainerActivity ? 1 : 0,
        "commute": isCommuteActivity ? 1 : 0
      };
}
