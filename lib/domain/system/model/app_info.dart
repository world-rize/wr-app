// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_info.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AppInfo {
  AppInfo({
    required this.currentVersion,
    required this.requireVersion,
    required this.isIOsAppAvailable,
    required this.isAndroidAppAvailable,
  });

  String currentVersion;

  String requireVersion;

  bool isIOsAppAvailable;

  bool isAndroidAppAvailable;

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return _$AppInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppInfoToJson(this);

  // TODO: versionのチェックをする
  bool get isValid {
    if (Platform.isIOS && isIOsAppAvailable) {
      return true;
    } else if (Platform.isAndroid && isAndroidAppAvailable) {
      return true;
    }
    return false;
  }
}
