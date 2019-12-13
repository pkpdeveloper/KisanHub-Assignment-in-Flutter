import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/login/login_widget.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/model/login_status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class AppRoutes {
  static get homeWidget => BlocProvider(
      key: Key('home_widget'),
      bloc: HomeScreenBloc(
          StreamController<ActivityStatus>.broadcast(), RestApi()),
      child: HomeWidget());

  static get loginWidget => BlocProvider(
      key: Key('login_widget'),
      bloc: UserLoginBloc(StreamController<LoginStatus>.broadcast(), RestApi()),
      child: LoginWidget());
}
