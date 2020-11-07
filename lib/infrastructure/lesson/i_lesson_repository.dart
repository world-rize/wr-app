// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/lesson/index.dart';

abstract class ILessonRepository {
  Future<List<Lesson>> loadAllLessons();
  Future<void> sendPhraseRequest({String text, String email});
  Future<List<Phrase>> newComingPhrases();
  bool getShowJapanese();
  void setShowJapanese({bool value});
  bool getShowEnglish();
  void setShowEnglish({bool value});
}
