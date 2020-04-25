// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhraseSample _$PhraseSampleFromJson(Map<String, dynamic> json) {
  return PhraseSample(
      content: (json['content'] as List)
          ?.map((e) => e == null
              ? null
              : Conversation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PhraseSampleToJson(PhraseSample instance) =>
    <String, dynamic>{'content': instance.content};
