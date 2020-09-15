// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map json) {
  return Note(
    id: json['id'] as String,
    title: json['title'] as String,
    sortType: json['sortType'] as String,
    isDefaultNote: json['isDefaultNote'] as bool,
    isAchievedNote: json['isAchievedNote'] as bool,
    phrases: (json['phrases'] as List)
        ?.map((e) => e == null ? null : NotePhrase.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefaultNote': instance.isDefaultNote,
      'isAchievedNote': instance.isAchievedNote,
      'phrases': instance.phrases?.map((e) => e?.toJson())?.toList(),
    };
