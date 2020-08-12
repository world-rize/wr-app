// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserActivity _$UserActivityFromJson(Map json) {
  return UserActivity(
    content: json['content'] as String,
    date: const CustomDateTimeConverter().fromJson(json['date'] as String),
  );
}

Map<String, dynamic> _$UserActivityToJson(UserActivity instance) =>
    <String, dynamic>{
      'content': instance.content,
      'date': const CustomDateTimeConverter().toJson(instance.date),
    };
