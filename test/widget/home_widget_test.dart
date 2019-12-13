import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

void main() {
  // Define the test key.
  final testKey = Key('K');

  testWidgets('HomeWidget test', (WidgetTester tester) async {
    final homeWidget = HomeWidget();
    final mainHomeWidget = BlocProvider(
        key: Key('home_widget'),
        bloc: HomeScreenBloc(
            StreamController<ActivityStatus>.broadcast(), RestApi()),
        child: homeWidget);
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        key: testKey,
        home: mainHomeWidget,
      ));

      // Create the Finders.
      final screenTitleFinder = find.text(AppConfig.homeScreenTitle);

      // Find the MaterialApp widget using the testKey.
      expect(find.byKey(testKey), findsOneWidget);
      expect(find.byKey(Key('loading_view')), findsOneWidget);

      // Verify
      expect(screenTitleFinder, findsOneWidget);

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byWidget(homeWidget), findsOneWidget);
      expect(find.byWidget(mainHomeWidget), findsOneWidget);
    });
  });
}
