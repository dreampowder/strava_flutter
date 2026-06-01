import 'dart:convert';
import 'dart:typed_data';

/// Pretty-prints any Strava API result (model, list of models, binary, or
/// primitive) as indented JSON.
String formatResult(dynamic result) {
  return const JsonEncoder.withIndent('  ').convert(_toEncodable(result));
}

dynamic _toEncodable(dynamic value) {
  if (value == null) return null;
  if (value is Uint8List) return '<binary: ${value.length} bytes>';
  if (value is num || value is String || value is bool) return value;
  if (value is List) return value.map(_toEncodable).toList();
  if (value is Map) {
    return value
        .map((k, v) => MapEntry(k.toString(), _toEncodable(v)));
  }
  try {
    // Strava models expose toJson(); explicit_to_json makes it fully expanded.
    return (value as dynamic).toJson();
  } catch (_) {
    return value.toString();
  }
}
