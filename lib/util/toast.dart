// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wr_app/util/logger.dart';

/// Toast class for debug
class NotifyToast {
  /// show success toast
  static void success(String message) {
    InAppLogger.info('[SuccessToast] $message');
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    );
  }

  /// show error toast with error [e]
  static void error(dynamic e) {
    InAppLogger.info('[ErrorToast] $e');
    Fluttertoast.showToast(
      msg: '$e',
      timeInSecForIosWeb: 3,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.redAccent,
    );
  }
}
