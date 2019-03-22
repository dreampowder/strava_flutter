// This is a basic test to check if there is any regression.
//

import 'package:flutter_test/flutter_test.dart';


import '../lib/secret.dart'; // Where Strava app secret is stored

import 'package:strava_flutter/API/strava.dart';
import 'package:strava_flutter/API/constants.dart';



void main() {
  

  test("Testing the test package !", () {
    var testouille = "foo,bar,baz";
    expect(testouille.split(","), equals(["foo", "bar", "baz"]));


  });

  test('Strava Authorization', ()  async {
    final strava = Strava(true, secret);
    final prompt = 'auto';
    expect(await strava.oauth
      ('3212',
        'activity:write,activity:read_all,profile:read_all,profile:write',
        secret, prompt
      ),
      equals(true)
    );

  });


}
