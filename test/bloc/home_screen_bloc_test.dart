import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/model/status.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('HomeScreen bloc test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      final _streamController = StreamController<ActivityStatus>.broadcast();
      final testData = Map<String, dynamic>();

      var mockApi = MockApi(testData);

      final _homeScreenBloc = HomeScreenBloc(_streamController, mockApi);

      // Verify onStart event
      _streamController.stream.listen((activityStatus) {
        if (activityStatus.status == Status.started) {
          expect(activityStatus.error, equals(null));
          expect(activityStatus.activities, equals(null));
        }

        // Verify onComplete with success event
        if (activityStatus.status == Status.completed) {
          expect(activityStatus.error, equals(null));
          expect(activityStatus.activities, equals(testData));
        }
        // Verify onComplete with error event
        if (activityStatus.status == Status.error) {
          expect(activityStatus.activities, equals(null));
        }
      });
      _homeScreenBloc.getActivities();
      await Future.delayed(Duration(milliseconds: 20)).then((onComplete) {});
      _streamController.close();
    });
  });
}

// Mock class
class MockApi extends Mock implements RestApi {
  final Map<String, dynamic> testData;

  MockApi(this.testData);

  @override
  Future<Map<String, dynamic>> getActivities() {
    return Future.value(testData);
  }
}
