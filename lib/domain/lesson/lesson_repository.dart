// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/lesson/index.dart';

abstract class LessonRepository {
  Future<List<Lesson>> loadAllLessons();
  Future<void> sendPhraseRequest({String text, String email});

  Future<List<Phrase>> newComingPhrases();

  bool getShowTranslation();
  void setShowTranslation({bool value});

  bool getShowText();
  void setShowText({bool value});
}
