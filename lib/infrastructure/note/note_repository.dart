// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';
import 'package:wr_app/util/logger.dart';

class NoteRepository implements INoteRepository {
  NoteRepository({@required this.store});

  final FirebaseFirestore store;

  CollectionReference get usersCollection => store.latest.collection('users');

  @override
  Future<Note> createNote({
    @required User user,
    @required Note note,
  }) async {
    user.notes.putIfAbsent(note.id, () => note);
    InAppLogger.debug('${note.toJson()}');
    await usersCollection.doc(user.uuid).set(user.toJson());
    return note;
  }

  @override
  Future<void> deleteNote({@required User user, @required Note note}) async {
    user.notes.removeWhere((key, value) => value.id == note.id);
    InAppLogger.debug('delete note $note');
    return usersCollection.doc(user.uuid).set(user.toJson());
  }

  @override
  Future<Note> updateNote({@required User user, @required Note note}) async {
    user.notes[note.id] = note;
    InAppLogger.debug('update note ${note.id}: ${note.title}');
    await usersCollection.doc(user.uuid).set(user.toJson());
    return note;
  }
}
