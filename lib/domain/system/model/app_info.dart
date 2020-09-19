// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_info.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AppInfo {
  AppInfo({
    @required this.currentVersion,
    @required this.requireVersion,
    @required this.isIOsAppAvailable,
    @required this.isAndroidAppAvailable,
  });

  String currentVersion;

  String requireVersion;

  bool isIOsAppAvailable;

  bool isAndroidAppAvailable;

  factory AppInfo.fromJson(Map<String, dynamic> json) =>
      _$AppInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppInfoToJson(this);
}
