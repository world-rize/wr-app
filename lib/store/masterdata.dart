// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:flutter/services.dart' show rootBundle;

class MasterDataStore with ChangeNotifier {
  static final Map<String, Section> _sections = {};
  static final MasterDataStore _cache = MasterDataStore._internal();

  factory MasterDataStore() {
    return _cache;
  }

  static Future<Section> _loadSectionFromJson(String path) {
    return rootBundle
        .loadString(path)
        .then((data) => jsonDecode(data))
        .then((json) => Section.fromJson(json));
  }

  static Phrase dummyPhrase({int i: 0}) {
    return Phrase(
      english: 'sample English text $i',
      japanese: 'サンプル日本語訳 $i',
      favorite: i % 2 == 0,
      sample: PhraseSample(content: []),
    );
  }

  static final List<Section> dummySections = List.generate(
    10,
    (i) => Section(
      title: 'セクション$i',
      phrases: List.generate(10, (i) => dummyPhrase(i: i)),
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
    final path = 'res/dummy.json';
    var section = await _loadSectionFromJson(path).catchError((error) {
      print(error);
    });

    print('${section.title} Loaded');
    _sections["dummy"] = section;
  }
}
