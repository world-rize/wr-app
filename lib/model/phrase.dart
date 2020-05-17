// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/assets.dart';
import 'package:wr_app/model/example.dart';
import 'package:json_annotation/json_annotation.dart';

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
