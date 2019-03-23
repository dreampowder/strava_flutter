// zones
import 'fault.dart';


class Zone {
  Fault fault;
  InfoZones infoZones;

  Zone({this.fault, this.infoZones});



  factory Zone.fromJson(Map<String, dynamic> firstJson) {
    if (firstJson['heart_rate'] != null) {
      var parsedJson = firstJson['heart_rate'];
      var _customZones = parsedJson['custom_zones'];
      var _infoZones =InfoZones();
      var list = parsedJson['zones'] as List;
      var fault = Fault(99, '');
      List<DistributionBucket> _distributionBucket = list.map((i) =>DistributionBucket.fromJson(i)).toList();
      _infoZones.customZones = _customZones;
      _infoZones.zones = _distributionBucket;

      return Zone(fault: fault, infoZones: _infoZones,);
    }
  }
}

class InfoZones {
  bool customZones;
  List<DistributionBucket> zones;
}


class DistributionBucket {
  int max;
  int min;
  

  DistributionBucket({this.max, this.min});

  DistributionBucket.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['max'] = this.max;
    data['min'] = this.min;
    return data;
  }
}

