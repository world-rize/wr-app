// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/usecase/exceptions.dart';

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

  /// throw NoteLimitExceeded
  /// AchievedNote + 3
  Future<Note> createNote({
    @required User user,
    @required Note note,
  }) async {
    final notes = await getAllNotes(user: user);
    if (notes.length >= 4) {
      throw NoteLimitExceeded('user: ${user.uuid}');
    }
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

  Future<Map<String, Note>> getAllNotes({@required User user}) {
    return _noteRepository.getAllNotes(user: user);
  }
}
