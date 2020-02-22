// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';

/// フレーズ例中の会話一文
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
class Conversation {
  Conversation(
      {@required this.english,
      @required this.japanese,
      @required this.avatarUrl});

  /// json to [Conversation]
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      english: json['english'],
      japanese: json['japanese'],
      avatarUrl: json['avatarUrl'],
    );
  }

  /// 英語
  String english;

  /// 日本語
  String japanese;

  /// チャットのアイコン画像URL
  String avatarUrl;

  /// [Conversation] to json
  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'japanese': japanese,
      'avatarUrl': avatarUrl,
    };
  }
}
