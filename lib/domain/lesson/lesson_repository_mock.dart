// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/assets.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

class LessonMockRepository implements ILessonRepository {
  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    return List<Lesson>.generate(
      6,
      (i) => Lesson(
        id: 'school.png$i',
        title: {
          'ja': 'School vol.$i',
        },
        phrases: List.generate(100, (index) => Phrase.dummy(index)),
        assets: Assets(
          img: {
            'thumbnail': 'https://source.unsplash.com/random/300x800',
          },
        ),
      ),
    );
  }

  @override
  Future<void> sendPhraseRequest({String text, String email}) {
    InAppLogger.log(text);
  }
}
