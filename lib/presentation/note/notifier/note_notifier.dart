import 'package:flutter/material.dart';

class NoteNotifier extends ChangeNotifier {
  String _nowSelectedNoteId;

  String get nowSelectedNoteId => _nowSelectedNoteId;

  set nowSelectedNoteId(String noteId) {
    _nowSelectedNoteId = noteId;
    notifyListeners();
  }
}
