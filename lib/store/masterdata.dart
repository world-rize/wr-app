// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:math';
import 'package:wr_app/api/mock.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wr_app/store/logger.dart';

/// マスタデータを保持するストア(__シングルトン__)
///
/// フレーズのデータ等を保持
class MasterDataStore with ChangeNotifier {
  factory MasterDataStore() {
    return _cache;
  }

  /// ストアの初期化
  /// 一度しか呼ばれない
  MasterDataStore._internal() {
    Logger.log('✨ MasterDataStore._internal()');

    try {
      _loadLessonsFromJson();
    } on Exception catch (e) {
      print(e);
      Logger.log('- Failed to init MasterDataStore');
    }
  }

  /// シングルトンインスタンス
  static final MasterDataStore _cache = MasterDataStore._internal();

  static final List<Lesson> _lessons = [];

  /// ローカルjsonファイルからレッスンをロード
  Future<void> _loadLessonsFromJson() async {
    const path = 'assets/lessons.json';

    Logger.log('\t Lessons @ $path');
    final lessons = await rootBundle
        .loadString(path)
        .then(jsonDecode)
        .then((json) => List.from(json))
        .then((list) =>
            List.from(list).map((json) => Lesson.fromJson(json)).toList());

    await Future.forEach(lessons, (lesson) async {
      lesson.phrases = await _loadPhrases(lesson);
    });

    _lessons.addAll(lessons);

    Logger.log('\t✨ ${_lessons.length} Lessons Loaded');

    await Future.forEach(_lessons, _loadPhrases);

    notifyListeners();
  }

  Future<List<Phrase>> _loadPhrases(Lesson lesson) async {
    final path = 'assets/lessons/${lesson.id}.json';

    Logger.log('\t${lesson.id} @ $path');
    return rootBundle.loadString(path).then(jsonDecode).then((list) =>
        List.from(list).map((json) => Phrase.fromJson(json)).toList());
  }

  Phrase getPhraseById({int i}) {
    return dummyPhrase(i: 1);
  }

  List<Section> getSectionsById({String id}) {
    final lesson = _lessons.firstWhere((lesson) => lesson.id == id);

    return Section.fromLesson(lesson);
  }

  List<Lesson> getLessons() {
    return _lessons;
  }

  List<Phrase> allPhrases() {
    return _lessons.expand((lesson) => lesson.phrases).toList();
  }

  List<String> randomSelections(Phrase phrase) {
    final selections = <String>[phrase.example.value[1].text['en']];
    final phrases = allPhrases();
    for (var i = 0; i < 3; i++) {
      final r = Random();
      final randomPhrase = phrases[r.nextInt(phrases.length)];
      selections.add(randomPhrase.example.value[1].text['en']);
    }
    assert(selections.length == 4);
    return selections;
  }
}
