// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';

class Conversation {
  Conversation(
      {@required this.english,
      @required this.japanese,
      @required this.avatarUrl});

  String english;
  String japanese;
  String avatarUrl;

  static Conversation fromJson(Map<String, dynamic> json) {
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
}

class PhraseSample {
  PhraseSample({@required this.content});

  List<Conversation> content;

  static PhraseSample fromJson(Map<String, dynamic> json) {
    return PhraseSample(
      content: List<Map<String, dynamic>>.from(json['content'])
          .map<Conversation>(Conversation.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((c) => c.toJson()),
    };
  }
}
