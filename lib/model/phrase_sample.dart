// Copyright © 2020 WorldRIZe. All rights reserved.

enum SampleType {
  None,
  Conversation,
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
  dynamic content;

  static fromJson(Map<String, dynamic> json) {
    return PhraseSample(
      type: SampleTypeHelper.fromValue(json['type']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': SampleTypeHelper.toValue(type),
      'content': content.toString(),
    };
  }

  PhraseSample({this.type: SampleType.None, this.content: ''});
}
