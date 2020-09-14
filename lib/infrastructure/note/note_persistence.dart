// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';

class NotePersistence implements NoteRepository {
  @override
  Future<Note> createNote(CreateNoteRequest req) {
    return callFunction('createNote', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) {
    return callFunction('deleteNote', req.toJson());
  }

  @override
  Future<Note> updateNote(UpdateNoteRequest req) {
    return callFunction('updateNote', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }
}
