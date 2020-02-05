// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/phrase.dart';

class Section {
  final String title;
  final List<Phrase> phrases;

  Section({this.title: '', this.phrases: const []});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      phrases: json['phrases'].map<Phrase>((p) => Phrase.fromJson(p)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'phrases': phrases.map((p) => p.toJson())};
  }
}

class Lesson {
  String title;
  String thumbnailUrl;

  Lesson(this.title, this.thumbnailUrl);
}
