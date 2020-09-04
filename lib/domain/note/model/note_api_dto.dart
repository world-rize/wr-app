// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';

part 'user_api_dto.g.dart';

// XXXRequestDto
// XXXResponseDto

// reason of `@JsonSerializable(explicitToJson: true, anyMap: true)`
// see https://stackoverflow.com/questions/58741971/casterror-type-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-of

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateNoteRequest {
  CreateNoteRequest({
    @required this.userId,
    @required this.title,
  });

  String userId;

  String title;

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateNoteTitleRequest {
  UpdateNoteTitleRequest({
    @required this.noteId,
    @required this.title,
  });

  String noteId;

  String title;

  factory UpdateNoteTitleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteTitleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNoteTitleRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateDefaultNoteRequest {
  UpdateDefaultNoteRequest({
    @required this.noteId,
  });

  String noteId;

  factory UpdateDefaultNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDefaultNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDefaultNoteRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeleteNoteRequest {
  DeleteNoteRequest({
    @required this.noteId,
  });

  String noteId;

  factory DeleteNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteNoteRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class AddPhraseInNoteRequest {
  AddPhraseInNoteRequest({
    @required this.noteId,
    @required this.phrase,
  });

  String noteId;

  Phrase phrase;

  factory AddPhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPhraseInNoteRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdatePhraseInNoteRequest {
  UpdatePhraseInNoteRequest({
    @required this.noteId,
    @required this.phraseId,
    @required this.phrase,
  });

  String noteId;

  String phraseId;

  Phrase phrase;

  factory UpdatePhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePhraseInNoteRequestToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeletePhraseInNoteRequest {
  DeletePhraseInNoteRequest({
    @required this.noteId,
    @required this.phraseId,
  });

  String noteId;

  String phraseId;

  factory DeletePhraseInNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePhraseInNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePhraseInNoteRequestToJson(this);
}
