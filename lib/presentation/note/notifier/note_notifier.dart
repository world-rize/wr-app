import 'package:flutter/material.dart';

class NoteNotifier extends ChangeNotifier {
  // TODO:
  // achievedなノートも実体として持っておき
  // achievedするとachievedノートに移動
  // 最初からリストを30個もつのは面倒くさいので
  // 最下部のカラムを空欄にしてそこを編集すると追加される感じに

  /// 現在のノート
  String _nowSelectedNoteId = 'default';

  /// 英語
  bool _canSeeEnglish = true;

  /// 日本語
  bool _canSeeJapanese = true;

  String get nowSelectedNoteId => _nowSelectedNoteId;

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
}
