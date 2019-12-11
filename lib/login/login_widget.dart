import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_hub/config/app_config.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.loginScreenTitle),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
