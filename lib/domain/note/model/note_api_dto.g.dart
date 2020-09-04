// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNoteRequest _$CreateNoteRequestFromJson(Map json) {
  return CreateNoteRequest(
    userId: json['userId'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$CreateNoteRequestToJson(CreateNoteRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
    };

UpdateNoteTitleRequest _$UpdateNoteTitleRequestFromJson(Map json) {
  return UpdateNoteTitleRequest(
    noteId: json['noteId'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$UpdateNoteTitleRequestToJson(
        UpdateNoteTitleRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'title': instance.title,
    };

UpdateDefaultNoteRequest _$UpdateDefaultNoteRequestFromJson(Map json) {
  return UpdateDefaultNoteRequest(
    noteId: json['noteId'] as String,
  );
}

Map<String, dynamic> _$UpdateDefaultNoteRequestToJson(
        UpdateDefaultNoteRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
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

AddPhraseInNoteRequest _$AddPhraseInNoteRequestFromJson(Map json) {
  return AddPhraseInNoteRequest(
    noteId: json['noteId'] as String,
    phrase: json['phrase'] == null
        ? null
        : Phrase.fromJson((json['phrase'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$AddPhraseInNoteRequestToJson(
        AddPhraseInNoteRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'phrase': instance.phrase?.toJson(),
    };

UpdatePhraseInNoteRequest _$UpdatePhraseInNoteRequestFromJson(Map json) {
  return UpdatePhraseInNoteRequest(
    noteId: json['noteId'] as String,
    phraseId: json['phraseId'] as String,
    phrase: json['phrase'] == null
        ? null
        : Phrase.fromJson((json['phrase'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$UpdatePhraseInNoteRequestToJson(
        UpdatePhraseInNoteRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'phraseId': instance.phraseId,
      'phrase': instance.phrase?.toJson(),
    };

DeletePhraseInNoteRequest _$DeletePhraseInNoteRequestFromJson(Map json) {
  return DeletePhraseInNoteRequest(
    noteId: json['noteId'] as String,
    phraseId: json['phraseId'] as String,
  );
}

Map<String, dynamic> _$DeletePhraseInNoteRequestToJson(
        DeletePhraseInNoteRequest instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'phraseId': instance.phraseId,
    };
