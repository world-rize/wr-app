// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:collection/collection.dart';
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
      _loadPhrases();
    } on Exception catch (e) {
      print(e);
      Logger.log('- Failed to init MasterDataStore');
    }
  }

  /// シングルトンインスタンス
  static final MasterDataStore _cache = MasterDataStore._internal();

  static final List<Lesson> _lessons = [];

  /// ローカルjsonファイルからレッスンをロード
  Future<void> _loadPhrases() async {
    const lessonsJsonPath = 'assets/lessons.json';
    const phrasesJsonPath = 'assets/phrases.json';

    Logger.log('\t Lessons Json @ $lessonsJsonPath');
    Logger.log('\t Phrases Json @ $phrasesJsonPath');

    // load lessons
    final lessons = await rootBundle
        .loadString(lessonsJsonPath)
        .then(jsonDecode)
        .then((json) => List.from(json))
        .then((list) =>
            List.from(list).map((json) => Lesson.fromJson(json)).toList())
        .catchError((e) {
      print(e);
      Logger.log(e.toString());
    });

    // load phrases
    final phrases = await rootBundle
        .loadString(phrasesJsonPath)
        .then(jsonDecode)
        .then((json) => List.from(json))
        .then((list) =>
            List.from(list).map((json) => Phrase.fromJson(json)).toList())
        .catchError((e) {
      print(e);
      Logger.log(e.toString());
    });

    // mapping phrases
    final phraseMap =
        groupBy<Phrase, String>(phrases, (phrase) => phrase.meta['lessonId']);

    lessons.forEach((lesson) {
      if (phraseMap.containsKey(lesson.id)) {
        lesson.phrases = phraseMap[lesson.id];
        Logger.log(
            '\t ${lesson.id}: ${phraseMap[lesson.id].length} phrases found');
      } else {
        Logger.log('\t warn ${lesson.id} not found');
      }
    });

    _lessons.addAll(lessons);

    Logger.log('\t✨ ${_lessons.length} Lessons Loaded');

    notifyListeners();
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
}
