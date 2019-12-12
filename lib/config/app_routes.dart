import 'package:flutter/material.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/home/home_widget.dart';
import 'package:kisan_hub/login/login_widget.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class AppRoutes {
  static get homeWidget => BlocProvider(
      key: Key('home_widget'), bloc: HomeScreenBloc(), child: HomeWidget());

  static get loginWidget => BlocProvider(
      key: Key('login_widget'), bloc: UserLoginBloc(), child: LoginWidget());
}
