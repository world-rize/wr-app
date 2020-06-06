// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wr_app/store/logger.dart';

class NotifyToast {
  /// 成功トーストを出す
  static void success(String message) {
    Logger.log('\t ✔ $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.lightGreen,
    );
  }

  /// エラートーストを出す
  static void error(dynamic e) {
    Logger.log('\t⚠ $e');
    Fluttertoast.showToast(
      msg: '$e',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }
}
