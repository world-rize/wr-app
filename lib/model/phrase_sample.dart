// Copyright © 2020 WorldRIZe. All rights reserved.

enum SampleType {
  None,
  Conversation,
}

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

  Conversation({this.english, this.japanese, this.avatarUrl});
}

class SampleTypeHelper {
  static SampleType fromValue(String type) {
    switch (type) {
      case 'conversation':
        return SampleType.Conversation;
      default:
        return SampleType.None;
    }
  }

  static String toValue(SampleType type) {
    switch (type) {
      case SampleType.Conversation:
        return 'conversation';
      default:
        return 'none';
    }
  }
}

class PhraseSample {
  SampleType type;
  List<Conversation> content;

  static fromJson(Map<String, dynamic> json) {
    return PhraseSample(
      type: SampleTypeHelper.fromValue(json['type']),
      // json['phrases'].map<Phrase>((p) => Phrase.fromJson(p)).toList(),
      content: List<Map<String, dynamic>>.from(json['content'])
          .map<Conversation>((c) => Conversation.fromJson(c))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': SampleTypeHelper.toValue(type),
      'content': content.map((c) => c.toJson()),
    };
  }

  PhraseSample({this.type: SampleType.None, this.content: const []});
}
