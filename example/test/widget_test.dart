// Smoke test: the explorer boots and shows the login affordance.

import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('shows login button and empty-state on launch', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login with Strava'), findsOneWidget);
    expect(find.text('Login to run API calls.'), findsOneWidget);
  });
}
