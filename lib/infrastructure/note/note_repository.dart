// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/infrastructure/note/i_note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

class NoteRepository implements INoteRepository {
  NoteRepository({@required this.store});

  final FirebaseFirestore store;

  CollectionReference get usersCollection => store.latest.collection('users');

  @override
  Future<Note> createNote({
    @required User user,
    @required Note note,
  }) async {
    await usersCollection
        .doc(user.uuid)
        .collection('notes')
        .doc(note.id)
        .set(note.toJson());
    InAppLogger.debug('createNote ${note.id}: ${note.title}');
    return note;
  }

  @override
  Future<void> deleteNote({@required User user, @required Note note}) async {
    await usersCollection
        .doc(user.uuid)
        .collection('notes')
        .doc(note.id)
        .delete();
    InAppLogger.debug('delete note ${note.id}: ${note.title}');
  }

  @override
  Future<Note> updateNote({@required User user, @required Note note}) async {
    await usersCollection
        .doc(user.uuid)
        .collection('notes')
        .doc(note.id)
        .set(note.toJson());
    InAppLogger.debug('update note ${note.id}: ${note.title}');
    return note;
  }

  @override
  Future<Map<String, Note>> getAllNotes({@required User user}) async {
    final m = <String, Note>{};
    await usersCollection
        .doc(user.uuid)
        .collection('notes')
        .get()
        .then((value) async {
      await Future.forEach(value.docs, (QueryDocumentSnapshot element) {
        final note = Note.fromJson(element.data());
        m[note.id] = note;
      });
    });
    return m;
  }
}
