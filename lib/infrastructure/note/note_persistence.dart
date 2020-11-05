// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';
import 'package:wr_app/domain/user/model/user.dart' as wr_user;
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/logger.dart';

class NotePersistence implements NoteRepository {
  @override
  Future<Note> createNote(CreateNoteRequest req) async {
    final firestore = FirebaseFirestore.instance;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      final user = wr_user.User.fromJson(value.data());
      user.notes.putIfAbsent(req.note.id, () => req.note);
      InAppLogger.debug('${req.note.toJson()}');
      return firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());
    });
    return req.note;
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) {
    final firestore = FirebaseFirestore.instance;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      final user = wr_user.User.fromJson(value.data());
      user.notes.removeWhere((key, value) => value.id == req.noteId);
      InAppLogger.debug('delete note ${req.noteId}');
      return firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());
    });
  }

  @override
  Future<Note> updateNote(UpdateNoteRequest req) async {
    final firestore = FirebaseFirestore.instance;
    final firebaseUser = FirebaseAuth.instance.currentUser;
    await firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((value) {
      final user = wr_user.User.fromJson(value.data());
      user.notes[req.note.id] = req.note;
      InAppLogger.debug('update note ${req.note.id}: ${req.note.title}');
      return firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());
    });
    return req.note;
  }
}
