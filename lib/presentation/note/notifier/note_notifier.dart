import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

/// NotePageの状態を管理する
class NoteNotifier extends ChangeNotifier {
  factory NoteNotifier({@required NoteService noteService}) {
    return _cache ??= NoteNotifier._(noteService: noteService);
  }

  NoteNotifier._({@required NoteService noteService})
      : _noteService = noteService;

  /// singleton
  static NoteNotifier _cache;
  NoteService _noteService;

  User _user = User.empty();

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  /// 現在のノート
  String _nowSelectedNoteId;

  Note get currentNote => _user.getNoteById(noteId: _nowSelectedNoteId);

  /// 英語
  bool _canSeeEnglish = true;

  /// 日本語
  bool _canSeeJapanese = true;

  String get nowSelectedNoteId {
    return _nowSelectedNoteId ??= user.getDefaultFavoriteList().id;
  }

  bool get canSeeEnglish => _canSeeEnglish;

  set canSeeEnglish(bool canSeeEnglish) {
    _canSeeEnglish = canSeeEnglish;
    notifyListeners();
  }

  bool get canSeeJapanese => _canSeeJapanese;

  set canSeeJapanese(bool canSeeJapanese) {
    _canSeeJapanese = canSeeJapanese;
    notifyListeners();
  }

  void toggleSeeEnglish() {
    _canSeeEnglish = !_canSeeEnglish;
    notifyListeners();
  }

  void toggleSeeJapanese() {
    _canSeeJapanese = !_canSeeJapanese;
    notifyListeners();
  }

  set nowSelectedNoteId(String noteId) {
    _nowSelectedNoteId = noteId;
    notifyListeners();
  }

  List<Note> getNotes() {
    return _user.notes.values.toList();
  }

  /// create note
  Future<void> createNote({
    @required String title,
  }) async {
    final newNote = Note.empty(title);
    final note = await _noteService.createNote(note: newNote);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('createNote ${note.id}');
    NotifyToast.success('createNote ${note.id}');
  }

  Note getDefaultNote() => _user.getDefaultNote();

  Note getAchievedNote() => _user.getAchievedNote();

  /// update note title
  Future<void> updateNote({
    @required Note note,
  }) async {
    await _noteService.updateNote(note: note);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('updateNoteTitle ${note.id}');
  }

  /// update note isDefault
  Future<void> updateDefaultNote({@required String noteId}) async {
    final defaultNote = _user.getDefaultNote();
    if (defaultNote != null) {
      defaultNote.isDefaultNote = false;
    }

    final note = _user.getNoteById(noteId: noteId).clone();
    note.isDefaultNote = true;

    await _noteService.updateNote(note: defaultNote);
    await _noteService.updateNote(note: note);
    _user.notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('updateDefaultNote ${note.id}');
    // NotifyToast.success('updateDefaultNote ${note.id}');
  }

  /// delete note
  Future<void> deleteNote({@required String noteId}) async {
    await _noteService.deleteNote(noteId: noteId);
    _user.notes.remove(noteId);

    notifyListeners();

    InAppLogger.info('updateDefaultNote $noteId');
    // NotifyToast.success('updateDefaultNote ${noteId}');
  }

  /// add phrase
  Future<void> addPhraseInNote({
    @required String noteId,
    @required NotePhrase phrase,
  }) async {
    final note = _user.getNoteById(noteId: noteId).clone();
    note.addPhrase(phrase);

    await _noteService.updateNote(note: note);
    _user.notes[noteId] = note;

    notifyListeners();

    InAppLogger.info('addPhraseInNote $noteId');
    // NotifyToast.success('addPhraseInNote ${noteId}');
  }

  /// update phrase
  Future<void> updatePhraseInNote({
    @required String noteId,
    @required String phraseId,
    @required NotePhrase phrase,
  }) async {
    final note = _user.getNoteById(noteId: noteId).clone();
    await _noteService.updateNote(note: note);
    _user.notes[note.id] = note;
    notifyListeners();
    InAppLogger.info('updatePhraseInNote $noteId');
  }

  Future<void> achievePhrase({
    @required String noteId,
    @required String phraseId,
  }) async {
    // blank note
    final note = _user.getNoteById(noteId: noteId);
    final phrase = note.findByNotePhraseId(phraseId);
    if (phrase == null) {
      throw Exception('note phrase not found');
    }

    // add to achieved note
    final addPhrase =
        NotePhrase.create(english: phrase.english, japanese: phrase.japanese);

    _user.getAchievedNote().addPhrase(addPhrase);

    // refresh phrase
    phrase
      ..japanese = ''
      ..english = '';
    note.updateNotePhrase(phrase.id, phrase);
    notifyListeners();
  }

  Future<void> addLessonPhraseToNote(String noteId, Phrase phrase) async {
    final note = _user.getNoteById(noteId: noteId);
    final notePhrase = note.firstEmptyNotePhrase();
    if (notePhrase == null) {
      InAppLogger.error('error happened');
      throw Exception("Can't add Phrase ${phrase.id} to Note ${note.id}");
    }
    notePhrase
      ..japanese = phrase.title['ja']
      ..english = phrase.title['en'];
    await _noteService.updateNote(note: note);
    notifyListeners();
  }
}
