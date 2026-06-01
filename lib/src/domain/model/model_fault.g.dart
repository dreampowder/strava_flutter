// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_fault.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fault _$FaultFromJson(Map<String, dynamic> json) => Fault(
  errors: _errorsFromJson(json['errors']),
  message: json['message'] as String?,
);

Map<String, dynamic> _$FaultToJson(Fault instance) => <String, dynamic>{
  'errors': _errorsToJson(instance.errors),
  'message': instance.message,
};

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
  code: json['code'] as String?,
  field: json['field'] as String?,
  resource: json['resource'] as String?,
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'code': instance.code,
  'field': instance.field,
  'resource': instance.resource,
};
