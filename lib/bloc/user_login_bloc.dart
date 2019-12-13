import 'dart:async';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/model/login_status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class UserLoginBloc extends BlocBase implements _UserLoginBlocContract {
  // Streams to handle the user
  final StreamController<LoginStatus> _loginStatusController;
  final RestApi _api;

  UserLoginBloc(
    this._loginStatusController,
    this._api,
  );

  Stream<LoginStatus> get loginStream => _loginStatusController.stream;

  @override
  void dispose() {
    _loginStatusController.close();
  }

  @override
  void login(String username, String password) {
    _loginStatusController.add(LoginStatus.onStarted());
    _api.login(username, password).then((userToken) {
      _loginStatusController.add(LoginStatus.onCompleted(username, userToken));
    }).catchError((onError) {
      _loginStatusController.add(LoginStatus.onError(onError));
    });
  }
}

abstract class _UserLoginBlocContract {
  void login(String username, String password);
}
