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
    isDefault: json['isDefault'] as bool,
    phrases: (json['phrases'] as List)
        ?.map((e) => e == null ? null : NotePhrase.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefault': instance.isDefault,
      'phrases': instance.phrases?.map((e) => e?.toJson())?.toList(),
    };
