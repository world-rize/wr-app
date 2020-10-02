// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';
import 'package:wr_app/domain/lesson/model/example.dart';
import 'package:wr_app/domain/lesson/model/message.dart';

part 'phrase.g.dart';

/// フレーズを表す
///
/// - フレーズはi18nされたタイトル
@JsonSerializable(explicitToJson: true, anyMap: true)
class Phrase {
  Phrase({
    @required this.id,
    @required this.title,
    @required this.assets,
    @required this.meta,
    @required this.advice,
    @required this.example,
  });

  factory Phrase.fromJson(Map json) => _$PhraseFromJson(json);

  /// minimum dummy
  factory Phrase.note(String uuid) {
    return Phrase(
      id: uuid,
      title: {
        'ja': 'フレーズ $uuid',
        'en': 'Phrase $uuid',
      },
      meta: {},
      assets: Assets.empty(),
      example: null,
      advice: {},
    );
  }

  /// ダミーのフレーズを返す
  factory Phrase.dummy(int index) {
    final dummyAssets = Assets(voice: {
      'en-us': 'voice_sample.mp3',
      'en-uk': 'voice_sample.mp3',
      'en-au': 'voice_sample.mp3',
    });

    final id = index.toString().padLeft(3, '0');

    return Phrase(
        id: id,
        title: {
          'ja': 'Dummy Phrase $id',
          'en': 'When is the homework due?',
        },
        meta: {
          'lessonId': 'Shcool',
        },
        assets: dummyAssets,
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
          // ignore: lines_longer_than_80_chars
          'ja':
              '“due”は「支払い期限のきた~」や「 満期の~」といった意味を持ちます。よって、”When is ~ due?”で「~の期限はいつだっけ？」となり、”When is the homework due?”を意訳すると「いつ宿題提出するんだっけ？」となります。',
        });
  }

  Map<String, dynamic> toJson() => _$PhraseToJson(this);

  /// return all voice paths
  List<String> voicePaths() {
    return [
      ...assets.voice.values.toList(),
      ...example.value.expand((message) => message.assets.voice.values.toList())
    ];
  }

  /// e.g. "business-41"
  String id;

  /// タイトル
  Map<String, String> title;

  /// キーフレーズ
  Assets assets;

  /// meta
  Map<String, String> meta;

  /// advice
  Map<String, String> advice;

  /// example
  Example example;
}
