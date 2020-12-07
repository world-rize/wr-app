import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/exceptions.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/sentry.dart';
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

  Map<String, Note> notes;

  User _user = User.empty();

  User get user => _user;

  set user(User user) {
    _user = user;
    _noteService.getAllNotes(user: user).then((value) {
      notes = value;
      nowSelectedNoteId =
          notes.values.firstWhere((element) => element.isDefaultNote).id;
      notifyListeners();
    });
    notifyListeners();
  }

  /// 現在のノート
  String _nowSelectedNoteId = 'dummy';

  String get nowSelectedNoteId => _nowSelectedNoteId;

  set nowSelectedNoteId(String noteId) {
    _nowSelectedNoteId = noteId;
    notifyListeners();
  }

  Note get currentNote {
    return notes[_nowSelectedNoteId];
  }

  /// 英語
  bool _canSeeEnglish = true;

  bool get canSeeEnglish => _canSeeEnglish;

  set canSeeEnglish(bool canSeeEnglish) {
    _canSeeEnglish = canSeeEnglish;
    notifyListeners();
  }

  /// 日本語
  bool _canSeeJapanese = true;

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

  /// create note
  Future<void> createNote({
    @required String title,
  }) async {
    final newNote = Note.empty(title);
    try {
      final note = await _noteService.createNote(user: _user, note: newNote);
      notes[note.id] = note;
      notifyListeners();

      InAppLogger.info('createNote ${note.id}');
      NotifyToast.success('createNote ${note.title}');
    } on NoteLimitExceeded {
      NotifyToast.error('これ以上ノートを作れません');
    }
  }

  Note getDefaultNote() =>
      notes.values.firstWhere((element) => element.isDefaultNote, orElse: () {
        sentryReportError(
            error: Exception('default note is not found. userId: ${user.uuid}'),
            stackTrace: StackTrace.current);
        return null;
      });

  Note getAchievedNote() =>
      notes.values.firstWhere((element) => element.isAchievedNote, orElse: () {
        sentryReportError(
            error:
                Exception('Achieved note is not found. userId: ${user.uuid}'),
            stackTrace: StackTrace.current);
        return null;
      });

  /// update note title
  Future<void> updateNote({
    @required Note note,
  }) async {
    await _noteService.updateNote(user: _user, note: note);
    notes[note.id] = note;

    notifyListeners();

    InAppLogger.info('updateNoteTitle ${note.id}');
  }

  /// delete note
  Future<void> deleteNote({@required String noteId}) async {
    final note = notes[noteId];
    await _noteService.deleteNote(user: _user, note: note);
    notes.remove(noteId);

    notifyListeners();

    InAppLogger.info('updateDefaultNote $noteId');
    // NotifyToast.success('updateDefaultNote ${noteId}');
  }

  /// add phrase
  Future<void> addPhraseInNote({
    @required String noteId,
    @required NotePhrase phrase,
  }) async {
    final note = notes[noteId]..addPhrase(phrase);

    await _noteService.updateNote(user: _user, note: note);
    notes[noteId] = note;

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
    try {
      final note = notes[noteId];
      await _noteService.updateNote(user: _user, note: note);
      notes[note.id] = note;
      notifyListeners();
      InAppLogger.info('updatePhraseInNote $noteId');
    } on Exception catch (e) {
      InAppLogger.error(e);
      rethrow;
    }
  }

  Future<void> achievePhrase({
    @required String noteId,
    @required String phraseId,
  }) async {
    // blank note
    final note = notes[noteId];
    final phrase = note.findByNotePhraseId(phraseId);
    if (phrase == null) {
      throw Exception('note phrase not found');
    }

    // add to achieved note
    final addPhrase =
        NotePhrase.create(english: phrase.english, japanese: phrase.japanese);

    getAchievedNote().addPhrase(addPhrase);

    // refresh phrase
    phrase
      ..japanese = ''
      ..english = '';
    note.updateNotePhrase(phrase.id, phrase);
    notifyListeners();
  }

  Future<void> addLessonPhraseToNote(String noteId, Phrase phrase) async {
    final note = notes[noteId];
    final notePhrase = note.firstEmptyNotePhrase();
    if (notePhrase == null) {
      InAppLogger.error('error happened');
      throw Exception("Can't add Phrase ${phrase.id} to Note ${note.id}");
    }
    notePhrase
      ..japanese = phrase.title['ja']
      ..english = phrase.title['en'];
    await _noteService.updateNote(user: _user, note: note);
    notifyListeners();
  }

  /// exist phrase in notes
  bool existPhraseInNotes({
    @required String phraseId,
  }) {
    return notes.values
        .any((list) => list.phrases.any((p) => p.id == phraseId));
  }
}
