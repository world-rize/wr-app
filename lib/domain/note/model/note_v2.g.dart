// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteV2 _$NoteV2FromJson(Map json) {
  return NoteV2(
    id: json['id'] as String,
    titleReversed: json['titleReversed'] as String,
  );
}

Map<String, dynamic> _$NoteV2ToJson(NoteV2 instance) => <String, dynamic>{
      'id': instance.id,
      'titleReversed': instance.titleReversed,
    };
