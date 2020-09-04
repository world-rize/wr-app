// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';

class NoteService {
  NoteService({
    @required NoteRepository notePersistence,
  }) : _notePersistence = notePersistence;

  final NoteRepository _notePersistence;

  Future<Note> createNote({
    @required String title,
  }) async {
    final req = CreateNoteRequest(title: title);
    return _notePersistence.createNote(req);
  }

  Future<Note> updateNoteTitle({
    @required String noteId,
    @required String title,
  }) {
    final req = UpdateNoteTitleRequest(noteId: noteId, title: title);
    return _notePersistence.updateNoteTitle(req);
  }

  Future<Note> updateDefaultNote({@required String noteId}) {
    final req = UpdateDefaultNoteRequest(noteId: noteId);
    return _notePersistence.updateDefaultNote(req);
  }

  Future<void> deleteNote({@required String noteId}) {
    final req = DeleteNoteRequest(noteId: noteId);
    return _notePersistence.deleteNote(req);
  }

  Future<Note> addPhraseInNote({
    @required String noteId,
    @required Phrase phrase,
  }) {
    final req = AddPhraseInNoteRequest(noteId: noteId, phrase: phrase);
    return _notePersistence.addPhraseInNote(req);
  }

  Future<Note> updatePhraseInNote({
    @required String noteId,
    @required String phraseId,
    @required Phrase phrase,
  }) {
    final req = UpdatePhraseInNoteRequest(
        noteId: noteId, phraseId: phraseId, phrase: phrase);
    return _notePersistence.updatePhraseInNote(req);
  }

  Future<void> deletePhraseInNote({
    @required String noteId,
    @required String phraseId,
  }) {
    final req = DeletePhraseInNoteRequest(noteId: noteId, phraseId: phraseId);
    return _notePersistence.deletePhraseInNote(req);
  }
}
