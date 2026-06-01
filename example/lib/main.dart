import 'dart:async';

import 'package:example/examples/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strava_client/strava_client.dart';

import 'api/api_models.dart';
import 'api/api_registry.dart';
import 'screens/call_screen.dart';
import 'secret.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strava Client Explorer',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFFC4C02), // Strava orange
        useMaterial3: true,
      ),
      home: const StravaExplorerPage(),
    );
  }
}

class StravaExplorerPage extends StatefulWidget {
  const StravaExplorerPage({super.key});

  @override
  State<StravaExplorerPage> createState() => _StravaExplorerPageState();
}

class _StravaExplorerPageState extends State<StravaExplorerPage> {
  final TextEditingController _tokenController = TextEditingController();
  late final StravaClient stravaClient;

  bool isLoggedIn = false;
  TokenResponse? token;

  @override
  void initState() {
    super.initState();
    stravaClient = StravaClient(secret: secret, clientId: clientId);
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  FutureOr<Null> _showError(dynamic error, dynamic stackTrace) {
    final message = error is Fault
        ? 'Fault: ${error.message}\n'
              '${(error.errors ?? []).map((e) => "• ${e.code} (${e.field})").join("\n")}'
        : error.toString();
    if (!mounted) return null;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request failed'),
        content: SingleChildScrollView(child: Text(message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return null;
  }

  void _login() {
    ExampleAuthentication(stravaClient)
        .testAuthentication(const [
          AuthenticationScope.profile_read_all,
          AuthenticationScope.read_all,
          AuthenticationScope.activity_read_all,
          AuthenticationScope.activity_write,
          AuthenticationScope.profile_write,
        ], "stravaflutter://redirect")
        .then((token) {
          setState(() {
            isLoggedIn = true;
            this.token = token;
            _tokenController.text = token.accessToken;
          });
        })
        .catchError(_showError);
  }

  void _logout() {
    ExampleAuthentication(stravaClient)
        .testDeauthorize()
        .then((_) {
          setState(() {
            isLoggedIn = false;
            token = null;
            _tokenController.clear();
          });
        })
        .catchError(_showError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Strava Client Explorer'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              isLoggedIn ? Icons.cloud_done : Icons.cloud_off,
              color: isLoggedIn ? Colors.green : Colors.red.shade300,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _loginPanel(),
          const Divider(height: 1),
          Expanded(child: _callList()),
        ],
      ),
    );
  }

  Widget _loginPanel() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FilledButton.icon(
                onPressed: _login,
                icon: const Icon(Icons.login),
                label: const Text('Login with Strava'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: isLoggedIn ? _logout : null,
                icon: const Icon(Icons.logout),
                label: const Text('De-authorize'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _tokenController,
            readOnly: true,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Access token',
              isDense: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _tokenController.text));
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Copied')));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _callList() {
    if (!isLoggedIn) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Login to run API calls.', textAlign: TextAlign.center),
        ),
      );
    }
    final grouped = groupedApiCalls();
    return ListView(
      children: grouped.entries.map((entry) {
        return ExpansionTile(
          title: Text(
            entry.key,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          children: entry.value.map(_callTile).toList(),
        );
      }).toList(),
    );
  }

  Widget _callTile(ApiCall call) {
    return ListTile(
      dense: true,
      title: Text(call.name),
      subtitle: Text(call.description),
      leading: call.isWrite
          ? const Icon(Icons.edit, color: Colors.orange, size: 20)
          : const Icon(Icons.download, color: Colors.blueGrey, size: 20),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CallScreen(client: stravaClient, call: call),
        ),
      ),
    );
  }
}
