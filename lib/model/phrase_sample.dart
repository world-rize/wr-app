// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';

class Conversation {
  String english;
  String japanese;
  String avatarUrl;

  static fromJson(Map<String, dynamic> json) {
    return Conversation(
      english: json['english'],
      japanese: json['japanese'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'english': english,
      'japanese': japanese,
      'avatarUrl': avatarUrl,
    };
  }

  Conversation(
      {@required this.english,
      @required this.japanese,
      @required this.avatarUrl});
}

class PhraseSample {
  List<Conversation> content;

  static fromJson(Map<String, dynamic> json) {
    return PhraseSample(
      content: List<Map<String, dynamic>>.from(json['content'])
          .map<Conversation>((c) => Conversation.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((c) => c.toJson()),
    };
  }

  PhraseSample({@required this.content});
}
