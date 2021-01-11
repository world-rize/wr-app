// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:stack_trace/stack_trace.dart' show Trace, Frame;
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

  static const start = '\x1b[90m';
  static const reset = '\x1b[0m';
  static const white = '\x1b[37m';

  static String logColor(int level) {
    if (level == -1) {
      return '\x1b[90m';
    }
    if (level == LogLevel.DEBUG) {
      return white;
    }
    if (level == LogLevel.INFO) {
      return '\x1b[37m';
    } else {
      return '';
    }
  }

  static String _format(int level, String content, Frame frame) {
    final time = DateFormat('HH:mm:ss').format(DateTime.now());
    return '${logColor(level)}$content\n  ${logColor(-1)}$frame [$time]$reset';
  }

  static void _log(int level, String content) {
    final frames = Trace.current(2).frames;
    final frame = frames.isEmpty ? null : frames.first;
    final log = _format(level, content, frame);

    _logs.add(UserActivity(
      content: content,
      date: null,
    ));

    if (logLevel <= level) {
      print(log);
    }
  }

  static String prettify(Map<String, dynamic> json) {
    final encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(json);
  }

  static void _logJson(int level, Map<String, dynamic> json) {
    final jsonString = prettify(json);
    final frames = Trace.current(2).frames;
    final frame = frames.isEmpty ? null : frames.first;
    final log = _format(level, '$jsonString\n', frame);

    _logs.add(UserActivity(
      content: jsonString,
      date: null,
    ));

    if (logLevel <= level) {
      print(log);
    }
  }

  static void debug(String content) => _log(LogLevel.DEBUG, content);

  static void debugJson(Map<String, dynamic> json) =>
      _logJson(LogLevel.DEBUG, json);

  static void info(String content) => _log(LogLevel.INFO, content);

  static void error(dynamic error) => _log(LogLevel.ERROR, error.toString());

  /// log history
  static List<UserActivity> getLogs() => _logs;
}
