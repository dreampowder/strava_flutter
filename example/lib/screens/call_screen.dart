import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strava_client/strava_client.dart';

import '../api/api_models.dart';
import '../api/result_format.dart';

/// A dynamic form + runner for a single [ApiCall].
class CallScreen extends StatefulWidget {
  final StravaClient client;
  final ApiCall call;

  const CallScreen({super.key, required this.client, required this.call});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, Object> _enumValues = {};
  final Map<String, bool> _boolValues = {};

  bool _loading = false;
  String? _result;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    for (final p in widget.call.params) {
      switch (p.type) {
        case ParamType.bool:
          _boolValues[p.key] = (p.defaultValue as bool?) ?? false;
          break;
        case ParamType.enumValue:
          _enumValues[p.key] =
              (p.defaultValue as Object?) ?? p.enumValues!.first;
          break;
        default:
          _controllers[p.key] = TextEditingController(text: _initialText(p));
      }
    }
  }

  String _initialText(ApiParam p) {
    final d = p.defaultValue;
    if (d == null) return '';
    if (d is DateTime) return d.toIso8601String();
    return d.toString();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> _collectArgs() {
    final args = <String, dynamic>{};
    for (final p in widget.call.params) {
      switch (p.type) {
        case ParamType.int:
          args[p.key] = int.parse(_controllers[p.key]!.text.trim());
          break;
        case ParamType.double:
          args[p.key] = double.parse(_controllers[p.key]!.text.trim());
          break;
        case ParamType.dateTime:
          args[p.key] = DateTime.parse(_controllers[p.key]!.text.trim());
          break;
        case ParamType.stringList:
          args[p.key] = _controllers[p.key]!.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
          break;
        case ParamType.string:
          args[p.key] = _controllers[p.key]!.text;
          break;
        case ParamType.bool:
          args[p.key] = _boolValues[p.key];
          break;
        case ParamType.enumValue:
          args[p.key] = _enumValues[p.key];
          break;
      }
    }
    return args;
  }

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _result = null;
      _isError = false;
    });
    try {
      final args = _collectArgs();
      final response = await widget.call.run(widget.client, args);
      setState(() => _result = formatResult(response));
    } on Fault catch (fault) {
      setState(() {
        _isError = true;
        _result = _formatFault(fault);
      });
    } catch (e, st) {
      setState(() {
        _isError = true;
        _result = 'Error: $e\n\n$st';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  String _formatFault(Fault fault) {
    final errors = (fault.errors ?? [])
        .map(
          (e) =>
              '  - code: ${e.code}, field: ${e.field}, '
              'resource: ${e.resource}',
        )
        .join('\n');
    return 'Strava Fault\nmessage: ${fault.message}\nerrors:\n$errors';
  }

  @override
  Widget build(BuildContext context) {
    final call = widget.call;
    return Scaffold(
      appBar: AppBar(
        title: Text(call.name),
        actions: [
          if (call.isWrite)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Chip(
                label: Text('WRITE'),
                backgroundColor: Color(0xFFFFE0B2),
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(call.description, style: Theme.of(context).textTheme.bodyMedium),
          if (call.isWrite)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '⚠ This call mutates your Strava data.',
                style: TextStyle(color: Colors.orange.shade800),
              ),
            ),
          const SizedBox(height: 16),
          ...call.params.map(_buildField),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _loading ? null : _run,
            icon: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.play_arrow),
            label: Text(_loading ? 'Running…' : 'Run'),
          ),
          const SizedBox(height: 16),
          if (_result != null) _buildResult(context),
        ],
      ),
    );
  }

  Widget _buildField(ApiParam p) {
    if (p.type == ParamType.bool) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(p.label),
        value: _boolValues[p.key]!,
        onChanged: (v) => setState(() => _boolValues[p.key] = v),
      );
    }
    if (p.type == ParamType.enumValue) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: p.label,
            border: const OutlineInputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Object>(
              isExpanded: true,
              value: _enumValues[p.key],
              items: p.enumValues!
                  .map(
                    (v) => DropdownMenuItem<Object>(
                      value: v,
                      child: Text(p.enumLabel?.call(v) ?? v.toString()),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _enumValues[p.key] = v!),
            ),
          ),
        ),
      );
    }
    final isNumber = p.type == ParamType.int || p.type == ParamType.double;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: _controllers[p.key],
        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true, signed: true)
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: p.label,
          helperText: p.hint,
          helperMaxLines: 3,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              _isError ? 'Error' : 'Response',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: _isError ? Colors.red : Colors.green.shade800,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(Icons.copy, size: 16),
              label: const Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _result ?? ''));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Copied')));
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isError ? const Color(0xFFFFEBEE) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(
            _result ?? '',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    );
  }
}
