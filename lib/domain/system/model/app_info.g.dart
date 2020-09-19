// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map json) {
  return AppInfo(
    currentVersion: json['currentVersion'] as String,
    requireVersion: json['requireVersion'] as String,
    isIOsAppAvailable: json['isIOsAppAvailable'] as bool,
    isAndroidAppAvailable: json['isAndroidAppAvailable'] as bool,
  );
}

Map<String, dynamic> _$AppInfoToJson(AppInfo instance) => <String, dynamic>{
      'currentVersion': instance.currentVersion,
      'requireVersion': instance.requireVersion,
      'isIOsAppAvailable': instance.isIOsAppAvailable,
      'isAndroidAppAvailable': instance.isAndroidAppAvailable,
    };
