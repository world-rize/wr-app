// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:wr_app/model/column/category.dart';
import 'package:wr_app/model/membership.dart';
import 'package:wr_app/model/phrase/assets.dart';
import 'package:wr_app/model/phrase/example.dart';
import 'package:wr_app/model/phrase/lesson.dart';
import 'package:wr_app/model/phrase/message.dart';
import 'package:wr_app/model/phrase/phrase.dart';
import 'package:wr_app/model/phrase/section.dart';
import 'package:wr_app/model/user.dart';

/// ダミーのフレーズを返す
Phrase dummyPhrase({int i = 1}) {
  final dummyAssets = Assets(voice: {
    'en-us': 'voice_sample.mp3',
    'en-uk': 'voice_sample.mp3',
    'en-au': 'voice_sample.mp3',
  });

  return Phrase(
      id: '0000',
      title: {
        'ja': 'いつ宿題提出するんだっけ？',
        'en': 'When is the homework due?',
      },
      meta: {
        'lessonId': 'Shcool',
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

/// ダミーのレッスンを返す
List<Lesson> dummyLessons() {
  return List<Lesson>.generate(
    6,
    (i) => Lesson(
      id: 'school.png$i',
      title: {
        'ja': 'School vol.$i',
      },
      phrases: [],
      assets: Assets(
        img: {
          'thumbnail': 'https://source.unsplash.com/random/300x800',
        },
      ),
    ),
  );
}

/// ダミーのセクションを返す
List<Section> dummySections() {
  return List.generate(
    7,
    (i) => Section(
      title: 'Section${i + 1}',
      phrases: List.generate(7, (i) => dummyPhrase(i: i + 1)),
    ),
  );
}

/// ダミーユーザー
User dummyUser() {
  return User(
    membership: Membership.normal,
    uuid: 'test-test',
    userId: '0123-4567-89',
    email: 'hoge@example.com',
    age: 10,
    name: 'テスト',
    point: 100,
    testLimitCount: 3,
    favorites: {},
  );
}

/// マークダウンファイル
String dummyRawArticle() => '''
---
title: Hello, world!
category: article
tags: [A, B, C]
---

# Hello World!
This is an example.
''';

/// # categories
/// - online_lesson
/// - article
/// - random
/// - listening
/// - comics
/// - cuisine
final List<Category> categories = [
  Category(
    id: 'online_lesson',
    title: 'オンライン英会話',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  Category(
    id: 'article',
    title: 'Articles',
    thumbnailUrl: 'assets/thumbnails/article.jpg',
  ),
  Category(
    id: 'random',
    title: 'Random facts',
    thumbnailUrl: 'assets/thumbnails/facts.png',
  ),
  Category(
    id: 'listening',
    title: 'Listening Practice',
    thumbnailUrl: 'assets/thumbnails/listening.jpg',
  ),
  Category(
    id: 'comics',
    title: 'Comics',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  Category(
    id: 'cuisine',
    title: 'cuisine from around the world',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
];
