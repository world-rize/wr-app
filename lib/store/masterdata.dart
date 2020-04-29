// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:developer' as dev;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/assets.dart';
import 'package:wr_app/model/message.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/example.dart';
import 'package:flutter/services.dart' show rootBundle;

/// マスタデータを保持するストア(__シングルトン__)
///
/// フレーズのデータ等を保持
class MasterDataStore with ChangeNotifier {
  factory MasterDataStore() {
    return _cache;
  }

  /// シングルトンインスタンス
  static final MasterDataStore _cache = MasterDataStore._internal();

  static final List<Phrase> _phrases = [];

  static final List<Lesson> _lessons = [];

  /// ローカルjsonファイルからレッスンをロード
  /// **試験的**
  static Future<List<Lesson>> _loadLessonsFromJson(String path) {
    dev.log('try to load lessons json from $path');
    return rootBundle
        .loadString(path)
        .then(jsonDecode)
        .then((res) => json.decode(res).map((obj) => Lesson.fromJson(obj)));
  }

  static Future<List<Phrase>> _loadPhrasesFromJson(String path) {
    dev.log('try to load phrases json from $path');
    return rootBundle
        .loadString(path)
        .then(jsonDecode)
        .then((res) => json.decode(res).map((obj) => Phrase.fromJson(obj)));
  }

  /// ダミーのフレーズを返す
  static Phrase dummyPhrase({int i = 1}) {
    final dummyAssets = Assets(voice: {
      'en-us': 'lessons/school/0001/en-us.mp3',
      'en-uk': 'lessons/school/0001/en-uk.mp3',
      'en-au': 'lessons/school/0001/en-au.mp3',
    });

    return Phrase(
        id: '0000',
        title: {
          'ja': 'いつ宿題提出するんだっけ？',
          'en': 'When is the homework due?',
        },
        meta: {
          'lessonId': '0001',
        },
        example: Example(value: [
          Message(
            text: {
              'ja': '宿題終わった?',
              'en': 'Have you finished the English homework yet?',
            },
            assets: dummyAssets,
          ),
          Message(
            text: {
              'ja': 'いや、終わってないよ\n(いつ宿題提出するんだっけ？)',
              'en': 'No I haven\'t.\n(When is the homework due?)',
            },
            assets: dummyAssets,
          ),
          Message(
            text: {
              'ja': '火曜日だよ',
              'en': 'It\'s due next Tuesday.',
            },
            assets: dummyAssets,
          ),
        ]),
        advice: {
          'ja':
              '“due”は「支払い期限のきた~」や「 満期の~」といった意味を持ちます。よって、”When is ~ due?”で「~の期限はいつだっけ？」となり、”When is the homework due?”を意訳すると「いつ宿題提出するんだっけ？」となります。',
        });
  }

  /// ダミーのセクションを返す
  static final List<Section> dummySections = List.generate(
    7,
    (i) => Section(
      title: 'Section${i + 1}',
      phrases: List.generate(7, (i) => dummyPhrase(i: i + 1)),
    ),
  );

  /// ダミーのレッスンを返す
  static final List<Lesson> dummyLessons = List<Lesson>.generate(
    6,
    (i) => Lesson(
      id: 'shcool$i',
      title: {
        'ja': 'School vol.$i',
      },
      assets: Assets(
        img: {
          'thumbnail': 'https://source.unsplash.com/category/nature/300x800',
        },
      ),
    ),
  );

  /// ストアの初期化
  /// 一度しか呼ばれない
  static _internal() async {
    print(dummyLessons);
    print(dummyLessons);

//    const path = 'assets/lessons/lessons.json';
//    final section = await _loadSectionFromJson(path).catchError(print);

//    print('${section.sectionTitle} Loaded');
//    _sections['dummy'] = section;
  }
}
