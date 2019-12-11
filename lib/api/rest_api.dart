import 'dart:convert';

import 'package:http/http.dart' as http;

class RestApi implements _RestApiContract {
  final baseUrl = 'https://kisanhub.mockable.io/flutter-test';

  @override
  Future<String> login(String username, String password) async {
    var url = baseUrl + '/login';
    var response = await http
        .post(url, body: {'username': username, 'password': password});
    Map<String, dynamic> resMap = json.decode(response.body);
    return resMap.isNotEmpty ? resMap['userToken'] : null;
  }

  @override
  Future<Map<String, dynamic>> getActivities() async {
    var url = baseUrl + '/activities';
    var response = await http.get(url);
    Map<String, dynamic> resMap = json.decode(response.body);
    return resMap;
  }
}

abstract class _RestApiContract {
  Future<String> login(String username, String password);

  Future<Map<String, dynamic>> getActivities();
}
