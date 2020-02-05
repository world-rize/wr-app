// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';

const dummyPhraseJson = '''
{
  "english": "When is the homework due?",
  "japanese": "いつ宿題するんだっけ",
  "favorite": true,
  "sample": {
    "type": "conversation",
    "content": [
      {
        "english": "Have you finished the English homework yet?",
        "japanese": "宿題終わった?",
        "avatartUrl": ""
      },
      {
        "english": "No I haven't.\\nWhen is the homework due?",
        "japanese": "いや、終わってないよ\\nいつ宿題提出するんだっけ？",
        "avatartUrl": ""
      },
      {
        "english": "It's due next Tuesday.",
        "japanese": "火曜日だよ",
        "avatartUrl": ""
      }
    ]
  },
  "advice": "\\"due\\"は「支払い期限のきた〜」や「満期の〜」といった"
}
''';

class SampleStore with ChangeNotifier {
  Phrase phrase = Phrase(english: '', japanese: '');

  SampleStore() {
    _fetch();
  }

  void _fetch() async {
    try {
      Map phraseMap = json.decode(dummyPhraseJson);
      phrase = Phrase.fromJson(phraseMap);
    } catch (e) {
      print('json decode error');
      print(e);
    }

    notifyListeners();
  }
}
