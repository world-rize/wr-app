// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phrase _$PhraseFromJson(Map<String, dynamic> json) {
  return Phrase(
      id: json['id'] as String,
      meta: (json['meta'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      advice: (json['advice'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      example: json['example'] == null
          ? null
          : Example.fromJson(json['example'] as Map<String, dynamic>))
    ..title = (json['title'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    );
}

Map<String, dynamic> _$PhraseToJson(Phrase instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'meta': instance.meta,
      'advice': instance.advice,
      'example': instance.example
    };
