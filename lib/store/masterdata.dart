// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:flutter/services.dart' show rootBundle;

class MasterDataStore with ChangeNotifier {
  factory MasterDataStore() {
    return _cache;
  }

  static final Map<String, Section> _sections = {};
  static final MasterDataStore _cache = MasterDataStore._internal();

  static Future<Section> _loadSectionFromJson(String path) {
    return rootBundle
        .loadString(path)
        .then(jsonDecode)
        .then((json) => Section.fromJson(json));
  }

  static Phrase dummyPhrase({int i = 1}) {
    return Phrase(
      english: 'sample English text $i',
      japanese: 'サンプル日本語訳 $i',
      audioPath: 'res/Welcome_1_.mp3',
      favorite: i % 2 == 0,
      sample: PhraseSample(content: []),
    );
  }

  static final List<Section> dummySections = List.generate(
    10,
    (i) => Section(
      lessonTitle: 'Shcool',
      sectionTitle: 'Section${i + 1}',
      phrases: List.generate(50, (i) => dummyPhrase(i: i + 1)),
    ),
  );

  static final List<Lesson> dummyLessons = List<Lesson>.generate(
    6,
    (i) => Lesson(
      'School$i',
      'https://source.unsplash.com/category/nature/300x800',
    ),
  );

  static _internal() async {
    const path = 'res/section1.json';
    final section = await _loadSectionFromJson(path).catchError(print);

    print('${section.sectionTitle} Loaded');
    _sections['dummy'] = section;
  }
}
