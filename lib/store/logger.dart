// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/activity.dart';

// アプリ内のログ
class InAppLogger {
  const InAppLogger();

  static List<Activity> logs = [];

  static void log(String text, {String type = 'default'}) {
    final now = DateTime.now();
    print('[$type/$now] $text');
    logs.add(Activity(uuid: '', type: type, text: text, date: now));
  }
}
