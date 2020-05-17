// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  static m0(point) => "${point} ポイントGet!";

  static m1(count, all) => "クリア[${count}/${all}]";

  static m2(membership) => "${Intl.select(membership, {'normal': '通常会員です', 'premium': 'プレミアム会員です✨✨', })}";

  static m3(point) => "${point} ポイント";

  static m4(q) => "${q}問目";

  static m5(clear) => "${Intl.select(clear, {'true': 'クリア', 'false': '未クリア', })}";

  static m6(title) => "${title}のテストを開始しますか?";

  static m7(limit, time) => "本日のテスト残り${limit}回\n制限時間${time}秒";

  static m8(success) => "${Intl.select(success, {'true': 'テストに合格！', 'false': 'テストに不合格...', })}";

  static m9(questions, corrects) => "${questions}問中${corrects}問正解！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accountPageTitle" : MessageLookupByLibrary.simpleMessage("Account"),
    "accountSection" : MessageLookupByLibrary.simpleMessage("アカウント"),
    "bottomNavAgency" : MessageLookupByLibrary.simpleMessage("Agency"),
    "bottomNavColumn" : MessageLookupByLibrary.simpleMessage("Columns"),
    "bottomNavLesson" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "bottomNavMyPage" : MessageLookupByLibrary.simpleMessage("My page"),
    "bottomNavTravel" : MessageLookupByLibrary.simpleMessage("Travel"),
    "close" : MessageLookupByLibrary.simpleMessage("閉じる"),
    "error" : MessageLookupByLibrary.simpleMessage("エラー"),
    "getPiece" : MessageLookupByLibrary.simpleMessage("ピースのカケラGet!"),
    "getPoints" : m0,
    "lessonStatus" : m1,
    "memberStatus" : m2,
    "myPageTitle" : MessageLookupByLibrary.simpleMessage("設定"),
    "next" : MessageLookupByLibrary.simpleMessage("次へ"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onePointAdvice" : MessageLookupByLibrary.simpleMessage("One Point Advice"),
    "otherSection" : MessageLookupByLibrary.simpleMessage("その他"),
    "phraseDetailTitle" : MessageLookupByLibrary.simpleMessage("Phrase Detail"),
    "points" : m3,
    "question" : m4,
    "requestPhrase" : MessageLookupByLibrary.simpleMessage("フレーズのリクエスト"),
    "requestPhraseButton" : MessageLookupByLibrary.simpleMessage("フレーズをリクエストする"),
    "sectionStatus" : m5,
    "studySection" : MessageLookupByLibrary.simpleMessage("学習"),
    "testClear" : MessageLookupByLibrary.simpleMessage("Test Clear!"),
    "testConfirm" : m6,
    "testInterrupt" : MessageLookupByLibrary.simpleMessage("テストを中断しますか?"),
    "testMessage" : m7,
    "testResult" : m8,
    "testScore" : m9,
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
