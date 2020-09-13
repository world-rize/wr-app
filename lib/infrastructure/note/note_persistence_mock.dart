// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence_mock.dart';
import 'package:wr_app/infrastructure/shop/shop_persistence_mock.dart';
import 'package:wr_app/usecase/note_service.dart';

class NotePersistenceMock implements NoteRepository {
  /// get current user
  User _readUserMock() {
    final notifier = UserNotifier(
      userService: UserService(
        authPersistence: AuthPersistenceMock(),
        userPersistence: UserPersistenceMock(),
        shopPersistence: ShopPersistenceMock(),
      ),
      noteService: NoteService(
        notePersistence: NotePersistenceMock(),
      ),
    );
    return notifier.getUser();
  }

  @override
  Future<Note> createNote(CreateNoteRequest req) async {
    final user = _readUserMock();
    final listId = Uuid().v4();
    user.notes[listId] = Note.empty(req.title);
    await Future.delayed(const Duration(seconds: 1));
    return user.notes[listId];
  }

  @override
  Future<void> deletePhraseInNote(DeletePhraseInNoteRequest req) async {}

  @override
  Future<Note> updatePhraseInNote(UpdatePhraseInNoteRequest req) async {
    final user = _readUserMock();
    if (!user.notes.containsKey(req.noteId)) {
      throw Exception('Note ${req.noteId} not found');
    }

    if (user.notes[req.noteId].findByNotePhraseId(req.phraseId) == null) {
      throw Exception('Phrase ${req.phraseId} not found');
    }

    user.notes[req.noteId].updateNotePhrase(req.phraseId, req.phrase);

    await Future.delayed(const Duration(seconds: 1));
    return user.notes[req.noteId];
  }

  @override
  Future<Note> addPhraseInNote(AddPhraseInNoteRequest req) async {
    final user = _readUserMock();
    if (!user.notes.containsKey(req.noteId)) {
      throw Exception('Note ${req.noteId} not found');
    }

    if (user.notes[req.noteId].addPhrase(req.phrase)) {
      throw Exception('Phrase ${req.phrase.id} cant add');
    }
    await Future.delayed(const Duration(seconds: 1));
    return user.notes[req.noteId];
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) async {}

  @override
  Future<Note> updateDefaultNote(UpdateDefaultNoteRequest req) async {
    return _readUserMock().notes[req.noteId]..isDefault = true;
  }

  @override
  Future<Note> updateNoteTitle(UpdateNoteTitleRequest req) async {
    return Note.dummy(req.title);
  }

  @override
  Future<void> achievePhraseInNote(AchievePhraseInNoteRequest req) async {
    final user = _readUserMock();
    if (!user.notes.containsKey(req.noteId)) {
      throw Exception('Note ${req.noteId} not found');
    }

    final notePhrase = user.notes[req.noteId].findByNotePhraseId(req.phraseId);
    notePhrase.achieved = req.achieve;
    user.notes[req.noteId].updateNotePhrase(req.phraseId, notePhrase);
    await Future.delayed(const Duration(seconds: 1));
    return user.notes[req.noteId];
  }
}
