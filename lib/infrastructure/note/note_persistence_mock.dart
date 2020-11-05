// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class NotePersistenceMock implements NoteRepository {
  const NotePersistenceMock({@required this.userRepository});

  final UserRepository userRepository;

  /// get current user
  User _readUserMock() {
    final notifier = UserNotifier(
      userService: UserService(
        userPersistence: userRepository,
      ),
    );
    return notifier.user;
  }

  @override
  Future<Note> createNote(CreateNoteRequest req) async {
    final user = _readUserMock();
    final listId = Uuid().v4();
    user.notes[listId] = req.note;
    await Future.delayed(const Duration(seconds: 1));
    return user.notes[listId];
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<Note> updateNote(UpdateNoteRequest req) {
    return Future.delayed(const Duration(seconds: 1)).then((_) => req.note);
  }
}
