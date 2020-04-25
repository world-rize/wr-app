// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phrase _$PhraseFromJson(Map<String, dynamic> json) {
  return Phrase(
      id: json['id'] as String,
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      audioPath: json['audioPath'] as String,
      favorite: json['favorite'] as bool,
      sample: json['sample'] == null
          ? null
          : PhraseSample.fromJson(json['sample'] as Map<String, dynamic>),
      advice: json['advice'] as String);
}

Map<String, dynamic> _$PhraseToJson(Phrase instance) => <String, dynamic>{
      'id': instance.id,
      'english': instance.english,
      'japanese': instance.japanese,
      'favorite': instance.favorite,
      'audioPath': instance.audioPath,
      'sample': instance.sample,
      'advice': instance.advice
    };
