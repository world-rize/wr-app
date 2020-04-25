// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase_sample.dart';

/// フレーズ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
///
/// json例
/// ```json
/// {
///  "lessonTitle": "School",
///  "sectionTitle": "Section1",
///  "phrases": [
///    {
///      "english": "When is the homework due?",
///      "japanese": "いつ宿題するんだっけ",
///      "audio": "res/Welcome_1_.mp3",
///      "favorite": true,
///      "sample": {
///        "content": [
///          {
///            "english": "Have you finished the English homework yet?",
///            "japanese": "宿題終わった?",
///            "avatarUrl": ""
///          },
///          {
///            "english": "No I haven't.\nWhen is the homework due?",
///            "japanese": "いや、終わってないよ\nいつ宿題提出するんだっけ？",
///            "avatarUrl": ""
///          },
///          {
///            "english": "It's due next Tuesday.",
///            "japanese": "火曜日だよ",
///            "avatarUrl": ""
///          }
///        ]
///      },
///      "advice": "\"due\"は「支払い期限のきた〜」や「満期の〜」といった"
///    },
///  ]
/// }
/// ```
class Phrase {
  Phrase({
    @required this.id,
    @required this.english,
    @required this.japanese,
    @required this.audioPath,
    this.favorite = false,
    @required this.sample,
    @required this.advice,
  });

  /// json to [Phrase]
  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      id: json['id'] as String,
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      audioPath: json['audio'] as String,
      favorite: json['favorite'] as bool,
      sample: PhraseSample.fromJson(json['sample']),
      advice: json['advice'] as String,
    );
  }

  /// ID
  String id;

  /// 英語本文
  String english;

  /// [japanese] 日本語訳
  String japanese;

  /// [audioPath] 英語音声のmp3ファイルのパス(res/...)
  bool favorite;

  /// [favorite] お気に入りをしているか
  String audioPath;

  /// [sample] 会話例、[PhraseSample] を参照
  PhraseSample sample;

  /// [advice] ワンポイントアドバイス
  String advice;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'english': english,
      'japanese': japanese,
      'favorite': favorite,
      'audio': audioPath,
      'sample': sample,
      'advice': advice,
    };
  }
}
