import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/login/login_widget.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';
import 'package:kisan_hub/widget/custom_navigation.dart';

void main() {
  // Define the test key.
  final testKey = Key('K');

  testWidgets('LoginWidget test', (WidgetTester tester) async {
    // Login Widget
    final childLoginWidget = LoginWidget();

    final mainLoginWidget =
        BlocProvider(bloc: UserLoginBloc(), child: childLoginWidget);

    await tester.pumpWidget(MaterialApp(
      key: testKey,
      home: mainLoginWidget,
    ));

    // Create the Finders.
    final usernameTextFieldFinder = find.byKey(Key('username'));
    final passwordTextFieldFinder = find.byKey(Key('password'));
    final loginCardWidgetFinder = find.byKey(Key('login_form'));
    final screenTitleFinder = find.text(AppConfig.loginScreenTitle);

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);

    // Verify
    expect(usernameTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(loginCardWidgetFinder, findsOneWidget);
    expect(screenTitleFinder, findsOneWidget);

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childLoginWidget), findsOneWidget);
    expect(find.byWidget(mainLoginWidget), findsOneWidget);
  });

  testWidgets('LoginWidget form submit test', (WidgetTester tester) async {
    // Login Widget
    final childLoginWidget = LoginWidget();

    final mainLoginWidget =
        BlocProvider(bloc: UserLoginBloc(), child: childLoginWidget);

    final streamController = StreamController<Widget>.broadcast();

    final customNavigationWidget = CustomNavigationWidget(
      child: mainLoginWidget,
      streamController: streamController,
    );

    await tester.pumpWidget(MaterialApp(
      home: customNavigationWidget,
    ));

    // Enter 'username' into the TextField.
    await tester.enterText(find.byKey(Key('username')), 'test@kisanhub.com');

    // Enter 'password' into the TextField.
    await tester.enterText(find.byKey(Key('password')), 'pass123');

    // Tap the add button.
    await tester.tap(find.byType(RaisedButton));

    // Rebuild the widget with the new item.
    await tester.pump();

    streamController.close();
  });
}
