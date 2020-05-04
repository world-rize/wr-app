// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;

// TODO(someone): refactoring
class Logger {
  static List<String> logs = [];

  static void log(String message, {String name: 'dev'}) {
    dev.log(message);
    logs.add('[$name] $message');
  }
}
