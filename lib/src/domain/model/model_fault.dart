import 'dart:convert';

class Fault {
  Fault({
    this.errors,
    this.message,
  });

  final List<Error>? errors;
  final String? message;

  factory Fault.fromRawJson(String str) => Fault.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fault.fromJson(Map<String, dynamic> json) => Fault(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from((errors ?? []).map((x) => x.toJson())),
        "message": message,
      };
}

class Error {
  Error({
    this.code,
    this.field,
    this.resource,
  });

  final String? code;
  final String? field;
  final String? resource;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        field: json["field"],
        resource: json["resource"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "field": field,
        "resource": resource,
      };
}
