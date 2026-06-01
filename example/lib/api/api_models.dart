import 'package:strava_client/strava_client.dart';

/// The kind of input an [ApiParam] collects.
enum ParamType { int, double, string, bool, stringList, dateTime, enumValue }

/// A single input for an [ApiCall].
class ApiParam {
  final String key;
  final String label;
  final ParamType type;
  final String? hint;

  /// Default value rendered into the field / used when left blank.
  final dynamic defaultValue;

  /// For [ParamType.enumValue]: the selectable values (usually `Enum.values`).
  final List<Object>? enumValues;

  /// For [ParamType.enumValue]: how to label each value in the dropdown.
  final String Function(Object value)? enumLabel;

  const ApiParam({
    required this.key,
    required this.label,
    required this.type,
    this.hint,
    this.defaultValue,
    this.enumValues,
    this.enumLabel,
  });
}

/// A runnable Strava API call, described declaratively so the UI can render a
/// form for it and execute it generically.
class ApiCall {
  final String group;
  final String name;
  final String description;
  final bool isWrite;
  final List<ApiParam> params;
  final Future<dynamic> Function(StravaClient client, Map<String, dynamic> args)
      run;

  const ApiCall({
    required this.group,
    required this.name,
    required this.description,
    required this.run,
    this.params = const [],
    this.isWrite = false,
  });
}
