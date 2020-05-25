// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:wr_app/model/article.dart';
import 'package:wr_app/model/assets.dart';
import 'package:wr_app/model/category.dart';
import 'package:wr_app/model/message.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/example.dart';
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

/// ダミーカテゴリ
List<Category> dummyCategories(int size) => List.generate(
      size,
      (i) => Category(
        title: 'Category $i',
        thumbnailUrl: 'https://source.unsplash.com/category/nature',
      ),
    );

Article dummyInAppArticle(int index) => Article.internal(
      id: '$index',
      title: '記事$index',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      content:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    );

Article dummyExternalArticle(int index) => Article.external(
      id: '$index',
      title: '記事$index',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      url: 'https://source.unsplash.com/category/nature',
    );

/// ダミー記事
List<Article> dummyArticles(int size) => List.generate(
      size,
      (index) => index % 2 == 0
          ? dummyInAppArticle(index)
          : dummyExternalArticle(index),
    );
