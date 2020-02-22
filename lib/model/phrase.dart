// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/phrase_sample.dart';

class Phrase {
  Phrase({
    this.english,
    this.japanese,
    this.audioPath,
    this.favorite = false,
    this.sample,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      audioPath: json['audio'] as String,
      favorite: json['favorite'] as bool,
      sample: PhraseSample.fromJson(json['sample']),
    );
  }

  // 英語
  String english;
  // 日本語
  String japanese;
  //  お気に入り
  bool favorite;
  // 音声のパス
  String audioPath;

  // 例
  PhraseSample sample;

  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'japanese': japanese,
      'favorite': favorite,
      'audio': audioPath,
      'sample': sample,
    };
  }
}
