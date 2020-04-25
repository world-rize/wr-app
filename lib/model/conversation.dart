// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation.g.dart';

/// フレーズ例中の会話一文
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
@JsonSerializable()
class Conversation {
  Conversation(
      {@required this.english,
      @required this.japanese,
      @required this.avatarUrl});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  /// 英語
  String english;

  /// 日本語
  String japanese;

  /// チャットのアイコン画像URL
  String avatarUrl;
}
