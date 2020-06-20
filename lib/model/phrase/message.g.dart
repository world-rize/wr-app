// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
      text: (json['text'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      assets: json['assets'] == null
          ? null
          : Assets.fromJson(json['assets'] as Map<String, dynamic>))
    ..type = json['@type'] as String;
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      '@type': instance.type,
      'text': instance.text,
      'assets': instance.assets
    };
