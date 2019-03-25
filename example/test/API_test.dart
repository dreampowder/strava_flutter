// API_test.dart

import "package:test/test.dart";
import 'package:strava_flutter/strava.dart';
import 'package:strava_flutter/Models/token.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'secret.dart';


void main()  {


   group("Authentication  --> ", () {
// Do authentication with the right scope
  final strava = Strava(
      true, // To get display info in API
      secret);

  bool isAuthOk = false;


  test ('oauth call ', () async {

    // print('${strava.secret}');
    // var _token = Token();

    // var isExpired = strava.isTokenExpired(_token);
    // print('$isExpired');


    const Map<String, dynamic> kTestValues= <String, dynamic>{
      'accessToken': null,
      'expire': null,
      'scope': null,
      'refreshToken': null,
     
    };

    // SharedPreferences.setMockInitialValues(kTestValues);
    SharedPreferences.setMockInitialValues(<String, dynamic>
    {'accessToken': 'null','expire': null,
     'scope': 'null',
     'refreshToken': 'null' });

     isAuthOk = await strava.oauth('32212', 'activity:write', secret, 'auto');

  print('---> Authentication result: $isAuthOk');

  });
 
  });

}


