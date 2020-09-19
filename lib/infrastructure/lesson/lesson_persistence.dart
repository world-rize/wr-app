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
  bool getShowTranslation() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('show_translation') ?? false;
  }

  @override
  void setShowTranslation({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('show_translation', value);
  }

  @override
  bool getShowText() {
    final pref = GetIt.I<SharedPreferences>();
    return pref.getBool('show_text') ?? true;
  }

  @override
  void setShowText({bool value}) {
    final pref = GetIt.I<SharedPreferences>();
    pref.setBool('show_text', value);
  }

  @override
  Future<List<Phrase>> newComingPhrases() async {
    final phrases = jsonDecode(tmpNewComingPhrases);
    return phrases;
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
"ja": "\"drongo\"はかなり強めに相手を侮辱する言葉で「バカ」というようなニュアンスで使われます。"
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
"ja": "\"yonks\"「長い間」という意味で使われます。ここでは\"ages\"や\"long time\"に置き換えることが可能です。"
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
},
{
"id": "aussie_40",
"title": {
"en": "I just gotta grab my bathers and a towel.",
"ja": "水着とタオルを持ってこないと"
},
"meta": {
"lessonId": "aussie",
"phraseId": "40"
},
"assets": {
"voice": {
"en-us": "voices/aussie_40_kp_en-us.mp3",
"en-au": "voices/aussie_40_kp_en-au.mp3",
"en-uk": "voices/aussie_40_kp_en-uk.mp3",
"en-in": "voices/aussie_40_kp_en-in.mp3"
}
},
"advice": {
"ja": "“bathers”はオーストラリアのスラングで「水着」のことです。"
},
"example": {
"value": [
{
"text": {
"en": "Do you wanna go to the beach today?",
"ja": "今日ビーチに行かない？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_40_1_en-us.mp3",
"en-au": "voices/aussie_40_1_en-au.mp3",
"en-uk": "voices/aussie_40_1_en-uk.mp3",
"en-in": "voices/aussie_40_1_en-in.mp3"
}
}
},
{
"text": {
"en": "Sure, (I just gotta grab my bathers and a towel.)",
"ja": "いいよ、(水着とタオルを持ってこないと）"
},
"assets": {
"voice": {
"en-us": "voices/aussie_40_2_en-us.mp3",
"en-au": "voices/aussie_40_2_en-au.mp3",
"en-uk": "voices/aussie_40_2_en-uk.mp3",
"en-in": "voices/aussie_40_2_en-in.mp3"
}
}
},
{
"text": {
"en": "I’ll get some sunscreen.",
"ja": "日焼け止めも持っていくね"
},
"assets": {
"voice": {
"en-us": "voices/aussie_40_3_en-us.mp3",
"en-au": "voices/aussie_40_3_en-au.mp3",
"en-uk": "voices/aussie_40_3_en-uk.mp3",
"en-in": "voices/aussie_40_3_en-in.mp3"
}
}
}
]
}
},
{
"id": "aussie_41",
"title": {
"en": "that bloke always dogs the boys.",
"ja": "あの男いつも裏切るんだよね"
},
"meta": {
"lessonId": "aussie",
"phraseId": "41"
},
"assets": {
"voice": {
"en-us": "voices/aussie_41_kp_en-us.mp3",
"en-au": "voices/aussie_41_kp_en-au.mp3",
"en-uk": "voices/aussie_41_kp_en-uk.mp3",
"en-in": "voices/aussie_41_kp_en-in.mp3"
}
},
"advice": {
"ja": "\"bloke\"は\"「男」を指す名詞で\"guy\"に置き換え可能です。また、\"dogs\"はここでは動詞\"dog\"に三人称単数の\"s\"がついたもので、ここでは\"dog\"は「犬」ではなく、「裏切る」という意味で使われます。\"betray\"と置き換えることができます。"
},
"example": {
"value": [
{
"text": {
"en": "I don't think Mike is coming out to drink tonight.",
"ja": "マイクは今日飲みに来なそうだね"
},
"assets": {
"voice": {
"en-us": "voices/aussie_41_1_en-us.mp3",
"en-au": "voices/aussie_41_1_en-au.mp3",
"en-uk": "voices/aussie_41_1_en-uk.mp3",
"en-in": "voices/aussie_41_1_en-in.mp3"
}
}
},
{
"text": {
"en": "Damn, (that bloke always dogs the boys.)",
"ja": "くそ、(あの男いつも裏切るんだよね)"
},
"assets": {
"voice": {
"en-us": "voices/aussie_41_2_en-us.mp3",
"en-au": "voices/aussie_41_2_en-au.mp3",
"en-uk": "voices/aussie_41_2_en-uk.mp3",
"en-in": "voices/aussie_41_2_en-in.mp3"
}
}
},
{
"text": {
"en": "Yeah, he's probably at home sleeping.",
"ja": "たぶん今家で寝てるよ"
},
"assets": {
"voice": {
"en-us": "voices/aussie_41_3_en-us.mp3",
"en-au": "voices/aussie_41_3_en-au.mp3",
"en-uk": "voices/aussie_41_3_en-uk.mp3",
"en-in": "voices/aussie_41_3_en-in.mp3"
}
}
}
]
}
},
{
"id": "aussie_42",
"title": {
"en": "I got your messo",
"ja": "メッセージ受け取ったよ"
},
"meta": {
"lessonId": "aussie",
"phraseId": "42"
},
"assets": {
"voice": {
"en-us": "voices/aussie_42_kp_en-us.mp3",
"en-au": "voices/aussie_42_kp_en-au.mp3",
"en-uk": "voices/aussie_42_kp_en-uk.mp3",
"en-in": "voices/aussie_42_kp_en-in.mp3"
}
},
"advice": {
"ja": "\"messo\"は\"message\"「メッセージ」の意味として使われます。よって、\"I got your messo\"で「メッセージ受け取ったよ」という意味になります。"
},
"example": {
"value": [
{
"text": {
"en": "Hey, (I got your messo) about the party.",
"ja": "おう、パーティーのことについての(メッセージ受け取ったよ)"
},
"assets": {
"voice": {
"en-us": "voices/aussie_42_1_en-us.mp3",
"en-au": "voices/aussie_42_1_en-au.mp3",
"en-uk": "voices/aussie_42_1_en-uk.mp3",
"en-in": "voices/aussie_42_1_en-in.mp3"
}
}
},
{
"text": {
"en": "Do you think you can go?",
"ja": "行けそう？"
},
"assets": {
"voice": {
"en-us": "voices/aussie_42_2_en-us.mp3",
"en-au": "voices/aussie_42_2_en-au.mp3",
"en-uk": "voices/aussie_42_2_en-uk.mp3",
"en-in": "voices/aussie_42_2_en-in.mp3"
}
}
},
{
"text": {
"en": "Yeah probably, I’ll have to ask for the next day off at work.",
"ja": "たぶんね、次の日休みにしてもらうように頼まなきゃ"
},
"assets": {
"voice": {
"en-us": "voices/aussie_42_3_en-us.mp3",
"en-au": "voices/aussie_42_3_en-au.mp3",
"en-uk": "voices/aussie_42_3_en-uk.mp3",
"en-in": "voices/aussie_42_3_en-in.mp3"
}
}
}
]
}
}]
""";
