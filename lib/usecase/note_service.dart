// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';

class NoteService {
  NoteService({
    @required INoteRepository noteRepository,
  }) : _noteRepository = noteRepository;

  final INoteRepository _noteRepository;

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
    return _noteRepository.createNote(user: user, note: note);
  }

  Future<void> deleteNote({
    @required User user,
    @required Note note,
  }) {
    return _noteRepository.deleteNote(user: user, note: note);
  }

  Future<void> updateNote({
    @required User user,
    @required Note note,
  }) {
    return _noteRepository.updateNote(user: user, note: note);
  }
}
