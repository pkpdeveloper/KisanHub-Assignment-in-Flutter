import 'package:flutter/material.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/login/login_widget.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: ThemeData(
        primarySwatch: AppConfig.primarySwatch,
      ),
      home: BlocProvider(
        bloc: HomeScreenBloc(),
        child: HomeWidget(),
      ),
    );
  }
}
