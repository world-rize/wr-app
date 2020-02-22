// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/conversation.dart';

/// フレーズ例
/// 現在は会話形式のみ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
class PhraseSample {
  PhraseSample({@required this.content});

  /// json to [PhraseSample]
  factory PhraseSample.fromJson(Map<String, dynamic> json) {
    return PhraseSample(
      content: List<Map<String, dynamic>>.from(json['content'])
          .map<Conversation>((c) => Conversation.fromJson(c))
          .toList(),
    );
  }

  /// 会話例
  List<Conversation> content;

  /// [PhraseSample] to json
  Map<String, dynamic> toJson() {
    return {
      'content': content.map((c) => c.toJson()),
    };
  }
}
