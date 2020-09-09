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
  Future<void> deletePhraseInNote(DeletePhraseInNoteRequest req) {
    return callFunction('deletePhraseInNote', req.toJson());
  }

  @override
  Future<Note> updatePhraseInNote(UpdatePhraseInNoteRequest req) {
    return callFunction('updatePhraseInNote', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }

  @override
  Future<Note> addPhraseInNote(AddPhraseInNoteRequest req) {
    return callFunction('addPhraseInNote', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) {
    return callFunction('deleteNote', req.toJson());
  }

  @override
  Future<Note> updateDefaultNote(UpdateDefaultNoteRequest req) {
    return callFunction('updateDefaultNote', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }

  @override
  Future<Note> updateNoteTitle(UpdateNoteTitleRequest req) {
    return callFunction('updateNoteTitle', req.toJson())
        .then((res) => Note.fromJson(res.data));
  }

  @override
  Future<void> achievePhraseInNote(AchievePhraseInNoteRequest req) {
    return callFunction('achievePhraseInNote', req.toJson());
  }
}
