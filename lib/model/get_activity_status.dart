import 'package:kisan_hub/model/status.dart';

class ActivityStatus {
  Map<String, dynamic> activities;
  Status status;
  dynamic error;

  ActivityStatus() {
    this.activities = null;
    this.status = null;
    this.error = null;
  }

  static ActivityStatus onStarted() {
    return ActivityStatus()..status = Status.started;
  }

  static ActivityStatus onCompleted(Map<String, dynamic> activities) {
    return ActivityStatus()
      ..activities = activities
      ..status = Status.completed;
  }

  static ActivityStatus onError(dynamic error) {
    return ActivityStatus()
      ..error = error
      ..status = Status.error;
  }
}
