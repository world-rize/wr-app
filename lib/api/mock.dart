// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:wr_app/model/column/article.dart';
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

Article dummyInAppArticle(int index) => Article.internal(
      id: '$index',
      title: '記事$index',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      content: """
# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.

## Titles

Setext-style

```
This is an H1
=============

This is an H2
-------------
```

Atx-style

```
# This is an H1

## This is an H2

###### This is an H6
```

Select the valid headers:

- [x] `# hello`
- [ ] `#hello`

## Links

[Google's Homepage][Google]

```
[inline-style](https://www.google.com)

[reference-style][Google]
```

## Images

![Flutter logo](/dart-lang/site-shared/master/src/_assets/image/flutter/icon/64.png)

## Tables

|Syntax                                 |Result                               |
|---------------------------------------|-------------------------------------|
|`*italic 1*`                           |*italic 1*                           |
|`_italic 2_`                           | _italic 2_                          |
|`**bold 1**`                           |**bold 1**                           |
|`__bold 2__`                           |__bold 2__                           |
|`This is a ~~strikethrough~~`          |This is a ~~strikethrough~~          |
|`***italic bold 1***`                  |***italic bold 1***                  |
|`___italic bold 2___`                  |___italic bold 2___                  |
|`***~~italic bold strikethrough 1~~***`|***~~italic bold strikethrough 1~~***|
|`~~***italic bold strikethrough 2***~~`|~~***italic bold strikethrough 2***~~|

## Styling
Style text as _italic_, __bold__, ~~strikethrough~~, or `inline code`.

- Use bulleted lists
- To better clarify
- Your points

## Code blocks
Formatted Dart code looks really pretty too:

```
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Markdown(data: markdownData),
    ),
  ));
}
```

## Markdown widget

This is an example of how to create your own Markdown widget:

    Markdown(data: 'Hello _world_!');

Enjoy!

[Google]: https://www.google.com/
""",
    );

Article dummyExternalArticle(int index) => Article.external(
      id: '$index',
      title: '記事$index',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      url: 'https://world-rize.com/',
    );

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

final List<Category> categories = [
  Category(
    id: 'online_lesson',
    title: 'オンライン英会話',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  Category(
    id: 'article',
    title: '記事',
    thumbnailUrl: 'assets/thumbnails/article.jpg',
  ),
  Category(
    id: 'listening',
    title: 'Listening Practice',
    thumbnailUrl: 'assets/thumbnails/listening.jpg',
  ),
  Category(
    id: 'illust',
    title: '絵付き漫画',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  Category(
    id: 'dish',
    title: '世界の料理',
    thumbnailUrl: 'assets/thumbnails/english.jpg',
  ),
  Category(
    id: 'tips',
    title: 'Random facts',
    thumbnailUrl: 'assets/thumbnails/facts.png',
  ),
];
