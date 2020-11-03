// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/note/model/note.dart';

part 'note_api_dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateNoteRequest {
  CreateNoteRequest({
    @required this.note,
  });

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);

  Note note;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdateNoteRequest {
  UpdateNoteRequest({
    @required this.note,
  });

  factory UpdateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNoteRequestToJson(this);

  Note note;
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
