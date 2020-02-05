// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/model/phrase_sample.dart';
import 'package:wr_app/model/section.dart';
import 'package:flutter/services.dart' show rootBundle;

Phrase dummyPhrase() {
  return Phrase(
    english: 'When is the homework due?',
    japanese: '宿題終わった?',
    favorite: true,
    sample: PhraseSample(type: SampleType.None, content: []),
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
