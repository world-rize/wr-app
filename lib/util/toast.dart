// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wr_app/util/logger.dart';

class NotifyToast {
  /// 成功トーストを出す
  static void success(String message) {
    InAppLogger.log('[SuccessToast] $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.greenAccent,
    );
  }

  /// エラートーストを出す
  static void error(dynamic e) {
    InAppLogger.log('[ErrorToast] $e');
    Fluttertoast.showToast(
      msg: '$e',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }
}
