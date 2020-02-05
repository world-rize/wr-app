// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/model/phrase.dart';

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
