// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/assets.dart';
import 'package:wr_app/domain/lesson/example.dart';

part 'phrase.g.dart';

@JsonSerializable()
class Phrase {
  Phrase({
    @required this.id,
    this.title,
    this.assets,
    this.meta,
    @required this.advice,
    @required this.example,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) => _$PhraseFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseToJson(this);

  List<String> voicePaths() {
    return [
      ...assets.voice.values.toList(),
      ...example.value.expand((message) => message.assets.voice.values.toList())
    ];
  }

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
