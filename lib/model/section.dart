// Copyright © 2020 WorldRIZe. All rights reserved.

class Phrase {
  String english;
  String japanese;
  bool favorite;

  Phrase({this.english, this.japanese, this.favorite: false});
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
