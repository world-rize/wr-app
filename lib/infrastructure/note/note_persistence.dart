// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';
import 'package:wr_app/domain/note/note_repository.dart';

class NotePersistence implements NoteRepository {
  @override
  Future<Note> createNote(CreateNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => Note.fromJson(res.data));
  }

  @override
  Future<void> deletePhraseInNote(DeletePhraseInNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deletePhraseInNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson());
  }

  @override
  Future<Note> updatePhraseInNote(UpdatePhraseInNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'updatePhraseInNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => Note.fromJson(res.data));
  }

  @override
  Future<Note> addPhraseInNote(AddPhraseInNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'addPhraseInNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => Note.fromJson(res.data));
  }

  @override
  Future<void> deleteNote(DeleteNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'deleteNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson());
  }

  @override
  Future<Note> updateDefaultNote(UpdateDefaultNoteRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'updateDefaultNote')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => Note.fromJson(res.data));
  }

  @override
  Future<Note> updateNoteTitle(UpdateNoteTitleRequest req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'updateNoteTitle')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req.toJson()).then((res) => Note.fromJson(res.data));
  }
}
