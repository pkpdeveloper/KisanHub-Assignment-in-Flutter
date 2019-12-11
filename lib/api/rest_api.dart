import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kisan_hub/model/user.dart';

class RestApi implements _RestApiContract {
  @override
  Future<User> login(String username, String password) async {
    var url = 'https://kisanhub.mockable.io/flutter-test/login';
    http.post(url, body: {'username': username, 'password': password}).then(
        (response) {
      var authToken = json.decode(response.body);
      return Future.value(User(username, authToken));
    }).catchError((onError) {
      return Future.error(onError);
    });
    return null;
  }
}

abstract class _RestApiContract {
  Future<User> login(String username, String password);
}
