// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phrase.g.dart';

@JsonSerializable()
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

  factory Phrase.fromJson(Map<String, dynamic> json) => _$PhraseFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseToJson(this);

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
}
