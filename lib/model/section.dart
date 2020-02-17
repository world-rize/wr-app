// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/phrase.dart';

class Section {
  Section({this.title = '', this.phrases = const []});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      phrases: json['phrases'].map<Phrase>((p) => Phrase.fromJson(p)).toList(),
    );
  }

  final String title;
  final List<Phrase> phrases;

  Map<String, dynamic> toJson() {
    return {'title': title, 'phrases': phrases.map((p) => p.toJson())};
  }
}

class Lesson {
  Lesson(this.title, this.thumbnailUrl);

  String title;
  String thumbnailUrl;
}
