// Copyright © 2020 WorldRIZe. All rights reserved.

// 会話の例
class PhraseSample {
  // TODO
}

// TODO
class Phrase {
  String english;
  String japanese;
  bool favorite;
  // TODO
  // PhraseSample sample;

  Phrase({this.english, this.japanese, this.favorite: false});

  Phrase.fromJson(Map<String, dynamic> json)
      : english = json['name'],
        japanese = json['email'],
        favorite = json['favorite'];

  Map<String, dynamic> toJson() => {
        'english': english,
        'japanese': japanese,
        'favorite': favorite,
      };
}

class Section {
  String title;
  List<Phrase> phrases;

  Section(this.title, this.phrases);
}

class Lesson {
  String title;
  String thumbnailUrl;

  Lesson(this.title, this.thumbnailUrl);
}
