// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/lesson/index.dart';

abstract class LessonRepository {
  Future<List<Lesson>> loadAllLessons();
  Future<void> sendPhraseRequest({required String text, required String email});
  Future<List<Phrase>> newComingPhrases();
  bool getShowJapanese();
  void setShowJapanese({required bool value});
  bool getShowEnglish();
  void setShowEnglish({required bool value});
}
