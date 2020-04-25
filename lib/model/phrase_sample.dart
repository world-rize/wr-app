// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/conversation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phrase_sample.g.dart';

/// フレーズ例
/// 現在は会話形式のみ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
@JsonSerializable()
class PhraseSample {
  PhraseSample({@required this.content});

  factory PhraseSample.fromJson(Map<String, dynamic> json) =>
      _$PhraseSampleFromJson(json);

  Map<String, dynamic> toJson() => _$PhraseSampleToJson(this);

  /// 会話例
  List<Conversation> content;
}
