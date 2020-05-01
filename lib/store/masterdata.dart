// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'dart:convert';
import 'package:wr_app/api/mock.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    dev.log('✨ MasterDataStore._internal()');

    try {
      _loadLessonsFromJson();
    } on Exception catch (e) {
      print(e);
      dev.log('- Failed to init MasterDataStore');
    }
  }

  /// シングルトンインスタンス
  static final MasterDataStore _cache = MasterDataStore._internal();

  static final List<Phrase> _phrases = [];

  static final List<Lesson> _lessons = [];

  /// ローカルjsonファイルからレッスンをロード
  static Future<void> _loadLessonsFromJson() async {
    const path = 'assets/lessons.json';

    dev.log('\t Lessons @ $path');
    await rootBundle.loadString(path).then(jsonDecode).then((list) {
      final lessons = List.from(list).map((json) => Lesson.fromJson(json));
      _lessons.addAll(lessons);
    });

    dev.log('\t✨ ${_lessons.length} Lessons Loaded');

    await Future.forEach(_lessons, _loadPhrases);

    dev.log('\t✨ ${_phrases.length} Phrases Loaded');
  }

  static Future<void> _loadPhrases(Lesson lesson) async {
    final path = 'assets/lessons/${lesson.id}.json';

    dev.log('\t${lesson.id} @ $path');
    await rootBundle.loadString(path).then(jsonDecode).then((list) {
      final lessons = List.from(list).map((json) => Phrase.fromJson(json));
      _phrases.addAll(lessons);
    });
  }

  Phrase getPhraseById({int i}) {
    return dummyPhrase(i: 1);
  }

  List<Section> getSectionsById({String id}) {
    return dummySections();
  }

  List<Lesson> getLessons() {
    return dummyLessons();
  }
}
