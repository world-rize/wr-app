// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:flutter/services.dart' show rootBundle;

class SampleStore with ChangeNotifier {
  Phrase phrase = Phrase(english: '', japanese: '');

  SampleStore() {
    _fetch();
  }

  void _fetch() async {
    final path = 'res/dummy.json';
    rootBundle.loadString(path).then((data) {
      print('[Asset Load] $path');
      return jsonDecode(data);
    }).then((json) {
      return Phrase.fromJson(json);
    }).then((phrase) {
      this.phrase = phrase;
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }
}
