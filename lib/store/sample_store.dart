// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:wr_app/model/section.dart';
import 'package:flutter/services.dart' show rootBundle;

Phrase dummyPhrase({int i: 0}) {
  return Phrase(
    english: 'sample English text $i',
    japanese: 'サンプル日本語訳 $i',
    favorite: i % 2 == 0,
    sample: PhraseSample(type: SampleType.Conversation, content: []),
  );
}

List<Section> dummySections() {
  return List.generate(
    10,
    (i) => Section(
      title: 'セクション$i',
      phrases: List.generate(10, (i) => dummyPhrase(i: i)),
    ),
  );
}

class EmptyStore with ChangeNotifier {
  EmptyStore();
}

class SampleStore with ChangeNotifier {
  Section section = Section();

  SampleStore() {
    _fetch();
  }

  void _fetch() async {
    final path = 'res/dummy.json';
    rootBundle.loadString(path).then((data) {
      print('[Asset Load] $path');
      return jsonDecode(data);
    }).then((json) {
      return Section.fromJson(json);
    }).then((phrase) {
      print('${phrase.title} Loaded');
      this.section = section;
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }
}
