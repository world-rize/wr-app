// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
      id: json['id'] as String,
      title: (json['title'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      phrases: (json['phrases'] as List)
          ?.map((e) =>
              e == null ? null : Phrase.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      assets: json['assets'] == null
          ? null
          : Assets.fromJson(json['assets'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'phrases': instance.phrases,
      'assets': instance.assets
    };
