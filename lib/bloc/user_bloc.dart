import 'dart:async';

import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/model/user.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class UserBloc extends BlocBase implements _UserBlocContract {
  // Streams to handle the user
  final _controller = StreamController<User>.broadcast();
  final _api = RestApi();

  @override
  void dispose() {
    _controller.close();
  }

  @override
  void login(String email, String password) {
    _api.login(email, password).then((user) {
      _controller.add(user);
    }).catchError((onError) {
      _controller.addError(onError);
    });
  }
}

abstract class _UserBlocContract {
  void login(String email, String password);
}
