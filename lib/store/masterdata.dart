// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/conversation.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:flutter/services.dart' show rootBundle;

/// マスタデータを保持するストア(__シングルトン__)
///
/// フレーズのデータ等を保持
class MasterDataStore with ChangeNotifier {
  /// シングルトンインスタンス
  static final MasterDataStore _cache = MasterDataStore._internal();

  factory MasterDataStore() {
    return _cache;
  }

  /// セクション名: セクション のマップ
  static final Map<String, Section> _sections = {};

  /// ローカルjsonファイルからセクションをロード
  /// **試験的**
  static Future<Section> _loadSectionFromJson(String path) {
    return rootBundle
        .loadString(path)
        .then(jsonDecode)
        .then((json) => Section.fromJson(json));
  }

  /// ダミーのフレーズを返す
  static Phrase dummyPhrase({int i = 1}) {
    return Phrase(
      id: i.toString(),
      english: 'When is the homework due?',
      japanese: 'いつ宿題提出するんだっけ？',
      audioPath: 'Welcome_1_.mp3',
      favorite: i % 2 == 0,
      sample: PhraseSample(
        content: [
          Conversation(
            japanese: '宿題終わった?',
            english: 'Have you finished the English homework yet?',
            avatarUrl: 'https://threadreaderapp.com/images/default_avatar.png',
          ),
          Conversation(
            japanese: 'いや、終わってないよ\n(いつ宿題提出するんだっけ？)',
            english: 'No I haven\'t.\n(When is the homework due?)',
            avatarUrl: 'https://threadreaderapp.com/images/default_avatar.png',
          ),
          Conversation(
            japanese: '火曜日だよ',
            english: 'It\'s due next Tuesday.',
            avatarUrl: 'https://threadreaderapp.com/images/default_avatar.png',
          ),
        ],
      ),
      advice:
          '“due”は「支払い期限のきた~」や「 満期の~」といった意味を持ちます。よって、”When is ~ due?”で「~の期限はいつだっけ？」となり、”When is the homework due?”を意訳すると「いつ宿題提出するんだっけ？」となります。',
    );
  }

  /// ダミーのセクションを返す
  static final List<Section> dummySections = List.generate(
    7,
    (i) => Section(
      lessonTitle: 'Shcool',
      sectionTitle: 'Section${i + 1}',
      phrases: List.generate(7, (i) => dummyPhrase(i: i + 1)),
    ),
  );

  /// ダミーのレッスンを返す
  static final List<Lesson> dummyLessons = List<Lesson>.generate(
    6,
    (i) => Lesson(
      'School$i',
      'https://source.unsplash.com/category/nature/300x800',
    ),
  );

  /// ストアの初期化
  /// 一度しか呼ばれない
  static _internal() async {
    const path = 'assets/section1.json';
    final section = await _loadSectionFromJson(path).catchError(print);

    print('${section.sectionTitle} Loaded');
    _sections['dummy'] = section;
  }
}
