// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    text: json['text'] as String,
    uuid: json['uuid'] as String,
    type: json['type'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'date': instance.date?.toIso8601String(),
      'type': instance.type,
      'text': instance.text,
    };
