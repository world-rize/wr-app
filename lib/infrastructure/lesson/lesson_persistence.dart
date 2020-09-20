// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/util/logger.dart';

/// load all lessons from local
Future<List<Lesson>> loadAllLessonsFromLocal({
  @required String lessonsJsonPath,
  @required String phrasesJsonPath,
}) async {
  // load lessons
  final lessons = await rootBundle
      .loadString(lessonsJsonPath)
      .then(jsonDecode)
      .then((json) => List.from(json))
      .then((list) =>
          List.from(list).map((json) => Lesson.fromJson(json)).toList());

  // load phrases
  final phrases = await rootBundle
      .loadString(phrasesJsonPath)
      .then(jsonDecode)
      .then((json) => List.from(json))
      .then((list) =>
          List.from(list).map((json) => Phrase.fromJson(json)).toList());

  // mapping phrases
  final phraseMap =
      groupBy<Phrase, String>(phrases, (phrase) => phrase.meta['lessonId']);

  lessons.forEach((lesson) {
    if (phraseMap.containsKey(lesson.id)) {
      lesson.phrases = phraseMap[lesson.id];
    }
  });

  return lessons;
}

class LessonPersistence implements LessonRepository {
  String SHOW_JAPANESE = 'show_japanese';
  String SHOW_ENGLISH = 'show_english';

  // load all phrases from local JSON
  @override
  Future<List<Lesson>> loadAllLessons() async {
    const lessonsJsonPath = 'assets/lessons.json';
    const phrasesJsonPath = 'assets/phrases.json';
    InAppLogger.info('\t Lessons Json @ $lessonsJsonPath');
    InAppLogger.info('\t Phrases Json @ $phrasesJsonPath');

    final lessons = await loadAllLessonsFromLocal(
      lessonsJsonPath: lessonsJsonPath,
      phrasesJsonPath: phrasesJsonPath,
    );

    // inspect
    lessons.forEach((lesson) {
      InAppLogger.debug(
          '\t ${lesson.id}: ${lesson.phrases.length} phrases found');
    });

    return lessons;
  }

  @override
  Future<void> sendPhraseRequest({
    @required String email,
    @required String text,
  }) {
    print('text $text');
    final request = Email(
      body: text,
      subject: 'WorldRIZe phrase request',
      recipients: [email],
      attachmentPaths: [],
      isHTML: false,
    );

    return FlutterEmailSender.send(request);
  }

  @override
  bool getShowJapanese() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool(SHOW_JAPANESE) ?? false;
  }

  @override
  void setShowEnglish({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool(SHOW_ENGLISH, value);
  }

  @override
  bool getShowEnglish() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool(SHOW_ENGLISH) ?? true;
  }

  @override
  void setShowJapanese({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool(SHOW_JAPANESE, value);
  }

  @override
  Future<List<Phrase>> newComingPhrases() async {
    final phrases = jsonDecode(tmpNewComingPhrases);
    return List.from(phrases).map((j) => Phrase.fromJson(j)).toList();
  }
}

const tmpNewComingPhrases = """[{
"id": "aussie_37",
"title": {
"en": "drongo",
"ja": "どういう意味？"
},
"meta": {
"lessonId": "aussie",
"phraseId": "37"
},
"assets": {
"voice": {
"en-us": "voices/aussie_37_kp_en-us.mp3",
"en-au": "voices/aussie_37_kp_en-au.mp3",
"en-uk": "voices/aussie_37_kp_en-uk.mp3",
"en-in": "voices/aussie_37_kp_en-in.mp3"
}
},
"advice": {
"ja": "\\"drongo\\"はかなり強めに相手を侮辱する言葉で「バカ」というようなニュアンスで使われます。"
},
"example": {
"value": [
{
"text": {
"en": "You're acting like a (drongo).",
"ja": "バカみたいだよ"
},
"assets": {
"voice": {
"en-us": "voices/aussie_37_1_en-us.mp3",
"en-au": "voices/aussie_37_1_en-au.mp3",
"en-uk": "voices/aussie_37_1_en-uk.mp3",
"en-in": "voices/aussie_37_1_en-in.mp3"
}
}
},
{
"text": {
"en": "What do you mean?",
"ja": "どういう意味？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_37_2_en-us.mp3",
"en-au": "voices/aussie_37_2_en-au.mp3",
"en-uk": "voices/aussie_37_2_en-uk.mp3",
"en-in": "voices/aussie_37_2_en-in.mp3"
}
}
},
{
"text": {
"en": "Can you please just sit still!?",
"ja": "じっと座ってられないの!？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_37_3_en-us.mp3",
"en-au": "voices/aussie_37_3_en-au.mp3",
"en-uk": "voices/aussie_37_3_en-uk.mp3",
"en-in": "voices/aussie_37_3_en-in.mp3"
}
}
}
]
}
},
{
"id": "aussie_38",
"title": {
"en": "I haven't seen you in yonks.",
"ja": "すごい長い間会ってなかった"
},
"meta": {
"lessonId": "aussie",
"phraseId": "38"
},
"assets": {
"voice": {
"en-us": "voices/aussie_38_kp_en-us.mp3",
"en-au": "voices/aussie_38_kp_en-au.mp3",
"en-uk": "voices/aussie_38_kp_en-uk.mp3",
"en-in": "voices/aussie_38_kp_en-in.mp3"
}
},
"advice": {
"ja": "\\"yonks\\"「長い間」という意味で使われます。ここでは\\"ages\\"や\\"long time\\"に置き換えることが可能です。"
},
"example": {
"value": [
{
"text": {
"en": "I feel like (I haven't seen you in yonks.)",
"ja": "(すごい長い間会ってなかった)ように感じるな"
},
"assets": {
"voice": {
"en-us": "voices/aussie_38_1_en-us.mp3",
"en-au": "voices/aussie_38_1_en-au.mp3",
"en-uk": "voices/aussie_38_1_en-uk.mp3",
"en-in": "voices/aussie_38_1_en-in.mp3"
}
}
},
{
"text": {
"en": "Yeah mate it's been a while, how are you?",
"ja": "そうだね、結構経ったね。元気だった？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_38_2_en-us.mp3",
"en-au": "voices/aussie_38_2_en-au.mp3",
"en-uk": "voices/aussie_38_2_en-uk.mp3",
"en-in": "voices/aussie_38_2_en-in.mp3"
}
}
},
{
"text": {
"en": "Not bad, yourself?",
"ja": "まぁまぁだね、君は？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_38_3_en-us.mp3",
"en-au": "voices/aussie_38_3_en-au.mp3",
"en-uk": "voices/aussie_38_3_en-uk.mp3",
"en-in": "voices/aussie_38_3_en-in.mp3"
}
}
}
]
}
},
{
"id": "aussie_39",
"title": {
"en": "I’m still feeling crook.",
"ja": "まだ体調が悪いの"
},
"meta": {
"lessonId": "aussie",
"phraseId": "39"
},
"assets": {
"voice": {
"en-us": "voices/aussie_39_kp_en-us.mp3",
"en-au": "voices/aussie_39_kp_en-au.mp3",
"en-uk": "voices/aussie_39_kp_en-uk.mp3",
"en-in": "voices/aussie_39_kp_en-in.mp3"
}
},
"advice": {
"ja": "“crook”の同意語として”unpleasant”や”unwell”が挙げられます。よって”feel crook”で体調が悪いという意味になります。"
},
"example": {
"value": [
{
"text": {
"en": "Are you coming tomorrow,  Emma?",
"ja": "エマ、明日って来れる？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_39_1_en-us.mp3",
"en-au": "voices/aussie_39_1_en-au.mp3",
"en-uk": "voices/aussie_39_1_en-uk.mp3",
"en-in": "voices/aussie_39_1_en-in.mp3"
}
}
},
{
"text": {
"en": "Probably not. (I’m still feeling crook.)",
"ja": "多分無理かな。(まだ体調が悪いの)"
},
"assets": {
"voice": {
"en-us": "voices/aussie_39_2_en-us.mp3",
"en-au": "voices/aussie_39_2_en-au.mp3",
"en-uk": "voices/aussie_39_2_en-uk.mp3",
"en-in": "voices/aussie_39_2_en-in.mp3"
}
}
},
{
"text": {
"en": "I hope you get better soon.",
"ja": "良くなるといいね"
},
"assets": {
"voice": {
"en-us": "voices/aussie_39_3_en-us.mp3",
"en-au": "voices/aussie_39_3_en-au.mp3",
"en-uk": "voices/aussie_39_3_en-uk.mp3",
"en-in": "voices/aussie_39_3_en-in.mp3"
}
}
}
]
}
}]
""";
