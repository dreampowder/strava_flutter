import 'dart:convert';

class SummaryGear {
  SummaryGear({
    required this.id,
    required this.primary,
    required this.name,
    required this.resourceState,
    required this.distance,
  });

  String id;
  bool primary;
  String name;
  int resourceState;
  int distance;

  factory SummaryGear.fromRawJson(String str) => SummaryGear.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryGear.fromJson(Map<String, dynamic> json) => SummaryGear(
    id: json["id"],
    primary: json["primary"],
    name: json["name"],
    resourceState: json["resource_state"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "primary": primary,
    "name": name,
    "resource_state": resourceState,
    "distance": distance,
  };
}

