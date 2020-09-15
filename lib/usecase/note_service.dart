// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/note/note_repository.dart';

class NoteService {
  NoteService({
    @required NoteRepository notePersistence,
  }) : _notePersistence = notePersistence;

  final NoteRepository _notePersistence;

  Note createDummyNote(String title, {bool isDefault = false}) {
    final phrases =
        List.generate(30, (index) => NotePhrase.dummy(id: Uuid().v4()));
    return Note(
      id: Uuid().v4(),
      title: title,
      isAchievedNote: false,
      isDefaultNote: isDefault,
      sortType: '',
      phrases: phrases,
    );
  }

  Future<Note> createNote({
    @required String title,
  }) async {
    final req = CreateNoteRequest(title: title);
    return _notePersistence.createNote(req);
  }

  Future<void> deleteNote({@required String noteId}) {
    final req = DeleteNoteRequest(noteId: noteId);
    return _notePersistence.deleteNote(req);
  }

  Future<void> updateNote({@required Note note}) {
    final req = UpdateNoteRequest(note: note);
    return _notePersistence.updateNote(req);
  }
}
