// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      avatarUrl: json['avatarUrl'] as String);
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'english': instance.english,
      'japanese': instance.japanese,
      'avatarUrl': instance.avatarUrl
    };
