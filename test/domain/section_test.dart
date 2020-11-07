// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/infrastructure/lesson/lesson_repository.dart';

void main() {
  // for using AssetBundle
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Section', () {
    test('Section.fromLesson()', () {
      final phrases = List.generate(42, (i) => Phrase.dummy(i));
      final lesson = Lesson(id: '', title: {}, phrases: phrases, assets: null);
      final sections = Section.fromLesson(lesson);

      expect(true, sections.every((section) => section.phrases.length == 7));
    });

    test('sections of all lessons has 7 phrases', () async {
      final repo = LessonRepository();
      final lessons = await repo.loadAllLessons();
      for (final lesson in lessons) {
        final sections = Section.fromLesson(lesson);
        expect(true, sections.every((section) => section.phrases.length == 7));
      }
    });
  });
}
