// Summary Athlete

import 'fault.dart';

class SummaryAthlete {
  Fault fault;
  int resourceState;
  String firstname;
  String lastname;
  String membership;
  bool admin;
  bool owner;

  SummaryAthlete(
      {this.fault,
      this.resourceState,
      this.firstname,
      this.lastname,
      this.membership,
      this.admin,
      this.owner});

  SummaryAthlete.fromJson(Map<String, dynamic> json) {
    resourceState = json['resource_state'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    membership = json['membership'];
    admin = json['admin'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resource_state'] = this.resourceState;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['membership'] = this.membership;
    data['admin'] = this.admin;
    data['owner'] = this.owner;
    return data;
  }
}
