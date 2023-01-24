
import 'package:strava_client/domain/model/model_activity_type_enum.dart';

class UpdateActivityRequest{
  String name;
  ActivityTypeEnum type;
  String description;
  bool isTrainerActivity;
  bool isCommuteActivity;
  String gearId;

  UpdateActivityRequest(this.name, this.type, this.description,
      this.isTrainerActivity, this.isCommuteActivity, this.gearId);

  Map<String,dynamic> toJson()=>{
    "name":name,
    "description":description,
    "type":type.stringValue(),
    "trainer":isTrainerActivity ? 1 : 0,
    "commute": isCommuteActivity ? 1 : 0,
    "gear_id":gearId
  };
}