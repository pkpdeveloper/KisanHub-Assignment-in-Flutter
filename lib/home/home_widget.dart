import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_hub/config/app_config.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.homeScreenTitle),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
