// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotePhrase _$NotePhraseFromJson(Map json) {
  return NotePhrase(
    id: json['id'] as String,
    english: json['english'] as String,
    japanese: json['japanese'] as String,
    createdAt: json['createdAt'] as String,
  );
}

Map<String, dynamic> _$NotePhraseToJson(NotePhrase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english': instance.english,
      'japanese': instance.japanese,
      'createdAt': instance.createdAt,
    };
