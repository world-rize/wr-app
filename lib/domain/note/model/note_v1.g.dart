// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteV1 _$NoteV1FromJson(Map json) {
  return NoteV1(
    id: json['id'] as String,
    titleUpperCase: json['titleUpperCase'] as String,
  );
}

Map<String, dynamic> _$NoteV1ToJson(NoteV1 instance) => <String, dynamic>{
      'id': instance.id,
      'titleUpperCase': instance.titleUpperCase,
    };
