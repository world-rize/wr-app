// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/note/note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';

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
    @required User user,
    @required Note note,
  }) async {
    return _notePersistence.createNote(user: user, note: note);
  }

  Future<void> deleteNote({
    @required User user,
    @required Note note,
  }) {
    return _notePersistence.deleteNote(user: user, note: note);
  }

  Future<void> updateNote({
    @required User user,
    @required Note note,
  }) {
    return _notePersistence.updateNote(user: user, note: note);
  }
}
