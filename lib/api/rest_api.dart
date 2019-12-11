import 'dart:convert';

import 'package:http/http.dart' as http;

class RestApi implements _RestApiContract {
  @override
  Future<String> login(String username, String password) async {
    var url = 'https://kisanhub.mockable.io/flutter-test/login';
    var response = await http
        .post(url, body: {'username': username, 'password': password});
    Map<String, dynamic> resMap = json.decode(response.body);
    return resMap.isNotEmpty ? resMap['userToken'] : null;
  }
}

abstract class _RestApiContract {
  Future<String> login(String username, String password);
}
