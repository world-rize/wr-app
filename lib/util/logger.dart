// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:wr_app/domain/system/model/user_activity.dart';

class LogLevel {
  static const DEBUG = 0;
  static const INFO = 1;
  static const WARN = 2;
  static const ERROR = 3;

  static String header(int level) {
    return ['DEBUG', 'INFO', 'WARN', 'ERROR'][level];
  }
}

// in-app logger
class InAppLogger {
  const InAppLogger();

  static final List<UserActivity> _logs = [];
  static const int logLevel = LogLevel.DEBUG;

  static void _log(int level, String content) {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm:ss');
    final timestamp = formatter.format(now);
    final header = LogLevel.header(level);
    final log = '[$timestamp][$header] $content';

    _logs.add(UserActivity(
      content: log,
      date: now,
    ));

    if (logLevel <= level) {
      print(log);
    }
  }

  static void _logJson(int level, Map<String, dynamic> json) {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm:ss');
    final timestamp = formatter.format(now);
    final header = LogLevel.header(level);

    final encoder = JsonEncoder.withIndent('  ');
    final jsonString = encoder.convert(json);

    final log = '[$timestamp][$header] $jsonString';

    _logs.add(UserActivity(
      content: log,
      date: now,
    ));

    if (logLevel <= level) {
      print(log);
    }
  }

  static void debug(String content) => _log(LogLevel.DEBUG, content);
  static void debugJson(Map<String, dynamic> json) =>
      _logJson(LogLevel.DEBUG, json);

  static void info(String content) => _log(LogLevel.INFO, content);

  /// log history
  static List<UserActivity> getLogs() => _logs;
}
