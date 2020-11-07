// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/util/logger.dart';

class NoteRepository implements INoteRepository {
  NoteRepository({@required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Future<Note> createNote({
    @required User user,
    @required Note note,
  }) async {
    user.notes.putIfAbsent(note.id, () => note);
    InAppLogger.debug('${note.toJson()}');
    await firestore.collection('users').doc(user.uuid).set(user.toJson());
    return note;
  }

  @override
  Future<void> deleteNote({@required User user, @required Note note}) {
    user.notes.removeWhere((key, value) => value.id == note.id);
    InAppLogger.debug('delete note $note');
    return firestore.collection('users').doc(user.uuid).set(user.toJson());
  }

  @override
  Future<Note> updateNote({@required User user, @required Note note}) async {
    await firestore.collection('users').doc(user.uuid).get().then((value) {
      final user = User.fromJson(value.data());
      user.notes[note.id] = note;
      InAppLogger.debug('update note ${note.id}: ${note.title}');
      return firestore.collection('users').doc(user.uuid).set(user.toJson());
    });
    return note;
  }
}
