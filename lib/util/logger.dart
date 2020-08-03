// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/system/model/activity.dart';

// in-app logger
class InAppLogger {
  const InAppLogger();

  static final List<Activity> _logs = [];

  /// log as a activity, [type] represent log category
  static void log(String text, {String type = 'default'}) {
    final now = DateTime.now();
    print('[$type/$now] $text');
    _logs.add(Activity(uuid: '', type: type, text: text, date: now));
  }

  /// log history
  static List<Activity> getLogs() => _logs;
}
