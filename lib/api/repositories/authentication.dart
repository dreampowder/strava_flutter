

abstract class StravaAuthenticationRepository{
  // Future<void> authenticate({
  //   required List<StravaAuthScope> scopes,
  //   required String redirectUrl,
  //   bool forceShowingApproval = false,
  // }) async{
  //   var completer = Completer();
  //   var token = await sl<SessionManager>().getToken();
  //   if (token == null) {
  //     completer.complete(_completeAuthentication(scopes: scopes, forceShowingApproval: forceShowingApproval, redirectUrl: redirectUrl));
  //   }else{
  //     List<StravaAuthScope> oldScopes = StravaAuthScopeHelper.generateScopes(token.scopes ?? "");
  //     var isScopesAreSame = _compareScopes(oldScopes, scopes);
  //     print("Scoped: $scopes");
  //     print("OldScopes: $oldScopes");
  //     print("isOldScopesSame: $isScopesAreSame");
  //     if(isScopesAreSame){
  //       if(sl<SessionManager>().isTokenExpired(token)){
  //         return _refreshAccessToken(sl<SessionManager>().clientId,sl<SessionManager>().secret,token.refreshToken)
  //             .then((refreshResult)=>sl<SessionManager>().setTTokenResponse scopes: scopes,
  //             token: AuthenticationResponse(
  //                 tokenType: token.tokenType,
  //                 expiresAt: refreshResult.expiresAt,
  //                 expiresIn: refreshResult.expiresIn,
  //                 refreshToken: refreshResult.refreshToken,
  //                 accessToken: refreshResult.accessToken)
  //         ));
  //       }else{
  //         print("Token is valid and can still be used");
  //         completer.complete();
  //       }
  //     }else{
  //       ///Scopes have changed. we need a new token.
  //       completer.complete(_completeAuthentication(scopes: scopes, forceShowingApproval: forceShowingApproval, redirectUrl: redirectUrl));
  //     }
  //   }
  //   return completer.future;
  // }
  //
  // Future<void> _completeAuthentication({
  //   required List<StravaAuthScope> scopes,
  //   required bool forceShowingApproval,
  //   required String redirectUrl
  // }){
  //   return _getStravaCode(redirectUrl: redirectUrl, scopes: scopes, forceShowingApproval: forceShowingApproval)
  //       .then((code){
  //       return _requestNewAccessToken(sl<SessionManager>().clientId, sl<SessionManager>().secret, code)
  //           .then((token){
  //            return sl<SessionManager>().setToken(token: token, scopes: scopes);
  //       });
  //   });
  // }
  //
  // Future<String> _getStravaCode(
  //     { required String redirectUrl,
  //       required List<StravaAuthScope> scopes,
  //       required bool forceShowingApproval}){
  //   final Completer<String> completer = Completer<String>();
  //   final params =
  //       '?client_id=${sl<SessionManager>().clientId}&redirect_uri=$redirectUrl&response_type=code&approval_prompt=${forceShowingApproval ? "force" : "auto"}&scope=${StravaAuthScopeHelper.buildScopeString(scopes)}';
  //   var authorizationEndpoint = "https://www.strava.com/oauth/mobile/authorize";
  //   final reqAuth = authorizationEndpoint + params;
  //
  //   launch(reqAuth,
  //       forceWebView: false,
  //       forceSafariVC: false,
  //       enableJavaScript: true);
  //   late final StreamSubscription linkStreamSubscription;
  //   linkStreamSubscription = uriLinkStream.listen((uri) {
  //     var error = uri?.queryParameters["error"];
  //     var code = uri?.queryParameters["code"];
  //     if(error != null){
  //       completer.completeError(StravaFault(errors: [],message: error));
  //     }else{
  //       completer.complete(code);
  //     }
  //     linkStreamSubscription.cancel();
  //   });
  //   return completer.future;
  // }
  //
  // Future<Token> _requestNewAccessToken(String clientID,
  //     String secret,
  //     String code){
  //   return ApiClient.postRequest(
  //       endPoint: "/v3/oauth/token",
  //       queryParameters: {
  //         "client_id":clientID,
  //         "client_secret":secret,
  //         "code":code,
  //         "grant_type":"authorization_code",
  //       },
  //       dataConstructor: (data)=>Token.fromJson(data));
  // }
  //
  // Future<RefreshToken> _refreshAccessToken(String clientID,String secret, String refreshToken){
  //   // client_id=$clientID&client_secret=$secret&grant_type=refresh_token&refresh_token=$refreshToken
  //   return ApiClient.postRequest<RefreshToken>(
  //       endPoint: "/v3/oauth/token",
  //       queryParameters: {
  //         "client_id":clientID,
  //         "client_secret":secret,
  //         "grant_type":"refresh_token",
  //         "refresh_token":refreshToken
  //       },
  //       dataConstructor: (data)=>RefreshToken.fromJson(data));
  // }
  //
  // bool _compareScopes(List<StravaAuthScope> left, List<StravaAuthScope> right){
  //   if (left.length != right.length) {
  //     return false;
  //   }
  //   return left.every((element) => right.contains(element));
  // }
}