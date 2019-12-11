import 'package:kisan_hub/model/status.dart';

class LoginStatus {
  String username;
  String userToken;
  Status status;
  dynamic error;

  LoginStatus() {
    this.username = null;
    this.userToken = null;
    this.status = null;
    this.error = null;
  }

  static LoginStatus onStarted() {
    return LoginStatus()..status = Status.started;
  }

  static LoginStatus onCompleted(String username, String userToken) {
    return LoginStatus()
      ..username = username
      ..userToken = userToken
      ..status = Status.completed;
  }

  static LoginStatus onError(dynamic error) {
    return LoginStatus()
      ..error = error
      ..status = Status.error;
  }
}
