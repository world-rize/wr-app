// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/system/model/activity.dart';

// アプリ内のログ
class InAppLogger {
  const InAppLogger();

  static final List<Activity> _logs = [];

  static void log(String text, {String type = 'default'}) {
    final now = DateTime.now();
    print('[$type/$now] $text');
    _logs.add(Activity(uuid: '', type: type, text: text, date: now));
  }

  static List<Activity> getLogs() => _logs;
}
