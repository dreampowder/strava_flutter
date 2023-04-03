// Requested scopes, as a comma delimited string, e.g. "activity:read_all,activity:write". Applications should request only the scopes required for the application to function normally. The scope activity:read is required for activity webhooks.
//
// read: read public segments, public routes, public profile data, public posts, public events, club feeds, and leaderboards
// read_all:read private routes, private segments, and private events for the user
// profile:read_all: read all profile information even if the user has set their profile visibility to Followers or Only You
// profile:write: update the user's weight and Functional Threshold Power (FTP), and access to star or unstar segments on their behalf
// activity:read: read the user's activity data for activities that are visible to Everyone and Followers, excluding privacy zone data
// activity:read_all: the same access as activity:read, plus privacy zone data and access to read the user's activities with visibility set to Only You
// activity:write: access to create manual activities and uploads, and access to edit any activities that are visible to the app, based on activity read access level

enum AuthenticationScope {
  read,
  read_all,
  profile_read_all,
  profile_write,
  activity_read,
  activity_read_all,
  activity_write,
  undefined_scope
}

extension AuthenticationScopeHelper on AuthenticationScope {
  String toScopeString() {
    switch (this) {
      case AuthenticationScope.read:
        return "read";
      case AuthenticationScope.read_all:
        return "read_all";
      case AuthenticationScope.profile_read_all:
        return "profile:read_all";
      case AuthenticationScope.profile_write:
        return "profile:write";
      case AuthenticationScope.activity_read:
        return "activity:read";
      case AuthenticationScope.activity_read_all:
        return "activity:read_all";
      case AuthenticationScope.activity_write:
        return "activity:write";
      case AuthenticationScope.undefined_scope:
        return "undefined";
    }
  }

  static AuthenticationScope getAuthScope(String value) {
    return AuthenticationScope.values.firstWhere(
        (e) => e.toScopeString() == value,
        orElse: () => AuthenticationScope.undefined_scope);
  }

  ///Builds comma separated scope string for strava.
  static String buildScopeString(List<AuthenticationScope> scopes) {
    return scopes.map((e) => e.toScopeString()).toList().join(",");
  }

  ///Generate enum list from scopes
  static List<AuthenticationScope> generateScopes(String scopeString) {
    List<String> scopeStrings = scopeString.split(",");
    return scopeStrings
        .map((e) => AuthenticationScopeHelper.getAuthScope(e))
        .toList();
  }
}
