import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/model/login_status.dart';
import 'package:kisan_hub/model/status.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('UserLogin bloc test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final _streamController = StreamController<LoginStatus>.broadcast();
      var mockApi = MockApi();
      var testToken = 'test_token';

      final _userLoginBloc = UserLoginBloc(_streamController, mockApi);

      // Verify onStart event
      _streamController.stream.listen((loginStatus) {
        if (loginStatus.status == Status.started) {
          expect(loginStatus.username, equals(null));
          expect(loginStatus.error, equals(null));
        }

        // Verify onComplete with success event
        if (loginStatus.status == Status.completed) {
          expect(loginStatus.username, equals('test_user'));
          expect(testToken, equals(loginStatus.userToken));
          expect(loginStatus.error, equals(null));
        }
        // Verify onComplete with error event
        if (loginStatus.status == Status.error) {
          expect(loginStatus.username, equals(null));
          expect(loginStatus.userToken, equals(null));
        }
      });
      _userLoginBloc.login('test_user', 'test_password');
      await Future.delayed(Duration(milliseconds: 20)).then((onComplete) {});
      _streamController.close();
    });
  });
}

// Mock class
class MockApi extends Mock implements RestApi {
  @override
  Future<String> login(String username, String password) {
    var testToken = 'test_token';
    return Future.value(testToken);
  }
}
