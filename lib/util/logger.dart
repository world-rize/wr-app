// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/system/model/user_activity.dart';

// in-app logger
class InAppLogger {
  const InAppLogger();

  static final List<UserActivity> _activities = [];

  /// log as a activity, [type] represent log category
  static void log(String text, {String type = 'default'}) {
    final now = DateTime.now();
    print('[$type/$now] $text');
    _activities.add(UserActivity(
      content: text,
      date: now,
    ));
  }

  /// log history
  static List<UserActivity> getLogs() => _activities;
}
