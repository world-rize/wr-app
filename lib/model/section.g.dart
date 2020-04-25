// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) {
  return Section(
      lessonTitle: json['lessonTitle'] as String,
      sectionTitle: json['sectionTitle'] as String,
      phrases: (json['phrases'] as List)
          ?.map((e) =>
              e == null ? null : Phrase.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'lessonTitle': instance.lessonTitle,
      'sectionTitle': instance.sectionTitle,
      'phrases': instance.phrases
    };
