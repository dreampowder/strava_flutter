import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'model_fault.g.dart';

/// Preserves the legacy behavior of mapping every entry of the `errors` array
/// into an [Error]. Mirrors the original hand-written
/// `List<Error>.from(json["errors"].map(...))` exactly (including the lack of a
/// null guard on the `errors` key).
List<Error>? _errorsFromJson(dynamic value) =>
    List<Error>.from(value.map((x) => Error.fromJson(x)));

/// Preserves the legacy behavior of always emitting an `errors` array, falling
/// back to an empty list when the field is null.
List<dynamic> _errorsToJson(List<Error>? errors) =>
    List<dynamic>.from((errors ?? []).map((x) => x.toJson()));

@JsonSerializable()
class Fault {
  Fault({this.errors, this.message});

  @JsonKey(name: "errors", fromJson: _errorsFromJson, toJson: _errorsToJson)
  final List<Error>? errors;

  @JsonKey(name: "message")
  final String? message;

  factory Fault.fromRawJson(String str) => Fault.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fault.fromJson(Map<String, dynamic> json) => _$FaultFromJson(json);

  Map<String, dynamic> toJson() => _$FaultToJson(this);
}

@JsonSerializable()
class Error {
  Error({this.code, this.field, this.resource});

  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "field")
  final String? field;

  @JsonKey(name: "resource")
  final String? resource;

  factory Error.fromRawJson(String str) => Error.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
