// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/phrase_sample.dart';

class Phrase {
  // 英語
  String english;
  // 日本語
  String japanese;
  //  お気に入り
  bool favorite;
  // 例
  PhraseSample sample;

  Phrase({this.english, this.japanese, this.favorite: false, this.sample});

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      english: json['english'],
      japanese: json['japanese'],
      favorite: json['favorite'],
      sample: PhraseSample.fromJson(json['sample']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'japanese': japanese,
      'favorite': favorite,
      'sample': sample,
    };
  }
}
