import 'dart:async';

import 'package:dio/dio.dart';
import 'package:strava_client/src/common/local_storage.dart';
import 'package:strava_client/src/domain/model/model_authentication_response.dart';
import 'package:strava_client/src/domain/model/model_authentication_scopes.dart';

class SessionManager {
  late String secret;
  late String clientId;
  late String applicationName;

  TokenResponse? _currentToken;
  // ignore: unused_field
  List<AuthenticationScope>? _scopes;

  void initialize({
    required String secret,
    required String clientId,
    String applicationName = "",
  }) {
    this.secret = secret;
    this.clientId = clientId;
    this.applicationName = applicationName;
  }

  Future<TokenResponse?> getToken() {
    var completer = Completer<TokenResponse?>();
    if (_currentToken != null) {
      completer.complete(_currentToken);
    } else {
      LocalStorageManager.getToken(applicationName: applicationName).then((
        storedValue,
      ) {
        if (storedValue != null) {
          _currentToken = storedValue;
        }
        completer.complete(_currentToken);
      });
    }
    return completer.future;
  }

  Future<void> setToken({
    required TokenResponse token,
    required List<AuthenticationScope> scopes,
  }) {
    _currentToken = token;
    _scopes = scopes;
    return LocalStorageManager.saveToken(
      token,
      scopes,
      applicationName: applicationName,
    ).then((value) => _currentToken = token);
  }

  bool isTokenExpired(TokenResponse token) {
    DateTime expiresAt = DateTime.fromMillisecondsSinceEpoch(
      token.expiresAt * 1000,
    );
    return DateTime.now().isAfter(expiresAt);
  }

  Future<TokenResponse?>? _refreshInFlight;

  /// Returns a non-expired token, transparently refreshing it via the stored
  /// refresh token when the current access token has expired.
  ///
  /// Concurrent callers share a single in-flight refresh. Returns `null` when
  /// no token is stored (i.e. the user has not authenticated yet).
  Future<TokenResponse?> getValidToken() async {
    final token = await getToken();
    if (token == null) return null;
    if (!isTokenExpired(token)) return token;
    return _refreshInFlight ??= _refreshToken(
      token,
    ).whenComplete(() => _refreshInFlight = null);
  }

  Future<TokenResponse> _refreshToken(TokenResponse token) async {
    final response = await Dio().post(
      "https://www.strava.com/api/v3/oauth/token",
      queryParameters: {
        "client_id": clientId,
        "client_secret": secret,
        "grant_type": "refresh_token",
        "refresh_token": token.refreshToken,
      },
    );
    final refreshed =
        TokenResponse.fromJson(Map<String, dynamic>.from(response.data))
          // The refresh response does not echo the granted scopes; carry the
          // previously stored scope string forward.
          ..scopes = token.scopes;
    await setToken(
      token: refreshed,
      scopes: AuthenticationScopeHelper.generateScopes(token.scopes ?? ""),
    );
    return refreshed;
  }

  Future<void> logout() {
    _currentToken = null;
    _scopes = null;
    return LocalStorageManager.deleteToken(applicationName: applicationName);
  }
}
