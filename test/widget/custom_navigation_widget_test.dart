import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';
import 'package:kisan_hub/widget/custom_navigation.dart';

void main() {
  testWidgets('CustomNavigationWidget form submit test',
      (WidgetTester tester) async {
    final streamController = StreamController<Widget>.broadcast();
    final testWidget = Container(
      key: Key('test_widget'),
    );
    final homeWidget = HomeWidget();
    final mainHomeWidget = BlocProvider(
        key: Key('home_widget'),
        bloc: HomeScreenBloc(
            StreamController<ActivityStatus>.broadcast(), RestApi()),
        child: homeWidget);
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
          home: CustomNavigationWidget(
        streamController: streamController,
        child: mainHomeWidget,
      )));

      // Search for the LoginWidget on default
      expect(find.byKey(Key('login_widget')), findsNothing);
      expect(find.byKey(Key('home_widget')), findsOneWidget);

      streamController.add(testWidget);

      await Future.delayed(const Duration(milliseconds: 100), () {});
      await tester.pump();
      expect(find.byKey(Key('test_widget')), findsOneWidget);

      streamController.close();
    });
  });
}
