// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(point) => "${point} coins Get!";

  static m1(count, all) => "クリア[${count}/${all}]";

  static m2(membership) => "${Intl.select(membership, {'normal': 'FREE', 'pro': 'PRO', })}";

  static m3(point) => "${point} coins";

  static m4(q) => "${q}問目";

  static m5(clear) => "${Intl.select(clear, {'true': 'クリア', 'false': '未クリア', })}";

  static m6(title) => "${title}のテストを開始しますか?";

  static m7(limit) => "本日のテスト残り${limit}回";

  static m8(questions, corrects) => "${questions}問中${corrects}問正解！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "bottomNavAgency" : MessageLookupByLibrary.simpleMessage("Agency"),
    "bottomNavColumn" : MessageLookupByLibrary.simpleMessage("Columns"),
    "bottomNavLesson" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "bottomNavMyPage" : MessageLookupByLibrary.simpleMessage("My page"),
    "bottomNavNote" : MessageLookupByLibrary.simpleMessage("Note"),
    "close" : MessageLookupByLibrary.simpleMessage("閉じる"),
    "error" : MessageLookupByLibrary.simpleMessage("エラー"),
    "getPoints" : m0,
    "lessonStatus" : m1,
    "memberStatus" : m2,
    "next" : MessageLookupByLibrary.simpleMessage("次へ"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onePointAdvice" : MessageLookupByLibrary.simpleMessage("One Point Advice"),
    "phraseDetailTitle" : MessageLookupByLibrary.simpleMessage("Phrase Detail"),
    "points" : m3,
    "question" : m4,
    "requestPhrase" : MessageLookupByLibrary.simpleMessage("フレーズのリクエスト"),
    "requestPhraseButton" : MessageLookupByLibrary.simpleMessage("フレーズをリクエストする"),
    "sectionStatus" : m5,
    "testClear" : MessageLookupByLibrary.simpleMessage("Test Clear!"),
    "testConfirm" : m6,
    "testInterrupt" : MessageLookupByLibrary.simpleMessage("テストを中断しますか?"),
    "testInterruptDetail" : MessageLookupByLibrary.simpleMessage("テストを中断した場合このテストは0点となり、1日のテスト受講可能回数は1回分消費されます"),
    "testLimitAlert" : MessageLookupByLibrary.simpleMessage("本日はこれ以上テストを受講することはできません"),
    "testLimitAlertDetail" : MessageLookupByLibrary.simpleMessage("テストは1日に3回まで受講することができます"),
    "testMessage" : m7,
    "testScore" : m8,
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
