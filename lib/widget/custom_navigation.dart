import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/login/login_widget.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class CustomNavigationWidget extends StatefulWidget {
  final streamController = StreamController<String>.broadcast();

  @override
  State<StatefulWidget> createState() {
    return _CustomNavigationWidgetState();
  }

  static CustomNavigationWidget of(BuildContext context) {
    return context.ancestorWidgetOfExactType(CustomNavigationWidget);
  }

  void route(String route) {
    streamController.add(route);
  }
}

class _CustomNavigationWidgetState extends State<CustomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    widget.streamController.stream.listen((onData) {
      if (mounted) {
        setState(() {
          print("widget refreshed");
        });
      }
    });
    final _homeWidget =
        BlocProvider(bloc: HomeScreenBloc(), child: HomeWidget());

    final _loginWidget =
        BlocProvider(bloc: UserLoginBloc(), child: LoginWidget());

    return AppConfig.userAuthToken != null ? _homeWidget : _loginWidget;
  }
}
