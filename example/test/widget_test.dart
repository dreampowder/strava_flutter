// widget_test.dart


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
// import 'package:strava_flutter/strava.dart';

void main(){
  testWidgets('Test strava_flutter example', (WidgetTester tester) async {

    MyApp exampleApp = MyApp();
    await tester.pumpWidget(exampleApp);

   

  });


}