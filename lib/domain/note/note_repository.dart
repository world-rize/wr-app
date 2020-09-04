// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_api_dto.dart';

abstract class NoteRepository {
  Future<Note> createNote(CreateNoteRequest req);

  Future<Note> updateNoteTitle(UpdateNoteTitleRequest req);

  Future<Note> updateDefaultNote(UpdateDefaultNoteRequest req);

  Future<void> deleteNote(DeleteNoteRequest req);

  Future<Note> addPhraseInNote(AddPhraseInNoteRequest req);

  Future<Note> updatePhraseInNote(UpdatePhraseInNoteRequest req);

  Future<void> deletePhraseInNote(DeletePhraseInNoteRequest req);
}
