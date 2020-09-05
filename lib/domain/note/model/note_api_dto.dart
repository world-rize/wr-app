// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

part 'note_api_dto.g.dart';

// XXXRequestDto
// XXXResponseDto

// reason of `@JsonSerializable(explicitToJson: true, anyMap: true)`
// see https://stackoverflow.com/questions/58741971/casterror-type-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-of

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateNoteRequest {
  CreateNoteRequest({
    @required this.title,
  });

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);

  String title;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateNoteTitleRequest {
  UpdateNoteTitleRequest({
    @required this.noteId,
    @required this.title,
  });

  factory UpdateNoteTitleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteTitleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNoteTitleRequestToJson(this);

  String noteId;

  String title;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateDefaultNoteRequest {
  UpdateDefaultNoteRequest({
    @required this.noteId,
  });

  factory UpdateDefaultNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDefaultNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDefaultNoteRequestToJson(this);

  String noteId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeleteNoteRequest {
  DeleteNoteRequest({
    @required this.noteId,
  });

  factory DeleteNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteNoteRequestToJson(this);

  String noteId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class AddPhraseInNoteRequest {
  AddPhraseInNoteRequest({
    @required this.noteId,
    @required this.phrase,
  });

  factory AddPhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPhraseInNoteRequestToJson(this);

  String noteId;

  NotePhrase phrase;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdatePhraseInNoteRequest {
  UpdatePhraseInNoteRequest({
    @required this.noteId,
    @required this.phraseId,
    @required this.phrase,
  });

  factory UpdatePhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePhraseInNoteRequestToJson(this);

  String noteId;

  String phraseId;

  NotePhrase phrase;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeletePhraseInNoteRequest {
  DeletePhraseInNoteRequest({
    @required this.noteId,
    @required this.phraseId,
  });

  factory DeletePhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePhraseInNoteRequestToJson(this);

  String noteId;

  String phraseId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class AchievePhraseInNoteRequest {
  AchievePhraseInNoteRequest({
    @required this.noteId,
    @required this.phraseId,
    @required this.achieve,
  });

  String noteId;

  String phraseId;

  bool achieve;

  factory AchievePhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$AchievePhraseInNoteFromJson(json);

  Map<String, dynamic> toJson() => _$AchievePhraseInNoteToJson(this);
}
