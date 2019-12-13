import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/config/app_routes.dart';
import 'package:kisan_hub/widget/custom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: ThemeData(
        primarySwatch: AppConfig.primarySwatch,
      ),
      home: CustomNavigationWidget(
        child: AppConfig.userAuthToken != null
            ? AppRoutes.homeWidget
            : AppRoutes.loginWidget,
        streamController: StreamController<Widget>.broadcast(),
      ),
    );
  }
}
