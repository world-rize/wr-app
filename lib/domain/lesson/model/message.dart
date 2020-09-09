// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';

part 'message.g.dart';

/// フレーズ例中の会話一文
@JsonSerializable()
class Message {
  Message({@required this.text, @required this.assets});

  factory Message.fromJson(Map<dynamic, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  /// タイプ: Message固定
  @JsonKey(name: '@type')
  String type = 'Message';

  /// フレーズとその訳
  ///
  /// ### 例
  /// 'en': Are you going out tonight?
  /// 'ja': 今夜遊びに行くの？
  Map<String, String> text;

  /// 音声などのアセットのパス
  Assets assets;
}
