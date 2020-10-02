// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNoteRequest _$CreateNoteRequestFromJson(Map json) {
  return CreateNoteRequest(
    note: json['note'] == null ? null : Note.fromJson(json['note'] as Map),
  );
}

Map<String, dynamic> _$CreateNoteRequestToJson(CreateNoteRequest instance) =>
    <String, dynamic>{
      'note': instance.note?.toJson(),
    };

UpdateNoteRequest _$UpdateNoteRequestFromJson(Map json) {
  return UpdateNoteRequest(
    note: json['note'] == null ? null : Note.fromJson(json['note'] as Map),
  );
}

Map<String, dynamic> _$UpdateNoteRequestToJson(UpdateNoteRequest instance) =>
    <String, dynamic>{
      'note': instance.note?.toJson(),
    };

DeleteNoteRequest _$DeleteNoteRequestFromJson(Map json) {
  return DeleteNoteRequest(
    noteId: json['noteId'] as String,
  );
}

Map<String, dynamic> _$DeleteNoteRequestToJson(DeleteNoteRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
    };
