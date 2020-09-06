// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotePhrase _$NotePhraseFromJson(Map json) {
  return NotePhrase(
    id: json['id'] as String,
    word: json['word'] as String,
    translation: json['translation'] as String,
    achieved: json['achieved'] as bool,
  );
}

Map<String, dynamic> _$NotePhraseToJson(NotePhrase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'translation': instance.translation,
      'achieved': instance.achieved,
    };
