// Constants.dart

enum ErrorCode {
  ok,
  headerIsEmpty,
  tokenIsInvalid,
  unknownError,
}



final tokenEndpoint = "https://www.strava.com/oauth/token";
final authorizationEndpoint = "https://www.strava.com/oauth/authorize";


class Fault {
  int statusCode;
  String message;

  Fault(this.statusCode, this.message);
}


