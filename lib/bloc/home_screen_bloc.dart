import 'dart:async';

import 'package:kisan_hub/api/rest_api.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';

class HomeScreenBloc extends BlocBase implements _HomeScreenBlocContract {
  final _activityStatusController =
      StreamController<ActivityStatus>.broadcast();

  Stream<ActivityStatus> get activityStream => _activityStatusController.stream;

  final _api = RestApi();

  @override
  void dispose() {
    _activityStatusController.close();
  }

  @override
  void getActivities() {
    _activityStatusController.add(ActivityStatus.onStarted());
    _api.getActivities().then((activities) {
      _activityStatusController.add(ActivityStatus.onCompleted(activities));
    }).catchError((onError) {
      _activityStatusController.add(ActivityStatus.onError(onError));
    });
  }
}

abstract class _HomeScreenBlocContract {
  void getActivities();
}
