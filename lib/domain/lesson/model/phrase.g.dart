// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phrase _$PhraseFromJson(Map json) {
  return Phrase(
    id: json['id'] as String,
    title: (json['title'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    assets: json['assets'] == null
        ? null
        : Assets.fromJson((json['assets'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    meta: (json['meta'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    advice: (json['advice'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as String),
    ),
    example: json['example'] == null
        ? null
        : Example.fromJson(json['example'] as Map),
  );
}

Map<String, dynamic> _$PhraseToJson(Phrase instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'assets': instance.assets?.toJson(),
      'meta': instance.meta,
      'advice': instance.advice,
      'example': instance.example?.toJson(),
    };
