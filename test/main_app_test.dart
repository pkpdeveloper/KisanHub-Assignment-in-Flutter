import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/main.dart';

void main() {
  // Define the test key.
  final testKey = Key('K');

  testWidgets('MyApp test', (WidgetTester tester) async {
    var myApp = MyApp();
    await tester.pumpWidget(MaterialApp(
      key: testKey,
      home: myApp,
    ));

    // Create the Finders.
    final homeScreenTitleFinder = find.text(AppConfig.homeScreenTitle);
    final loginScreenTitleFinder = find.text(AppConfig.loginScreenTitle);

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);

    // Verify
    expect(loginScreenTitleFinder, findsOneWidget);

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byKey(Key('login_widget')), findsOneWidget);
  });
}
