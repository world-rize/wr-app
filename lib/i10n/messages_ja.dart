// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static m0(point) => "${point} coins Get!";

  static m1(count, all) => "クリア[${count}/${all}]";

  static m2(membership) => "${Intl.select(membership, {'normal': 'FREE', 'pro': 'PRO', })}";

  static m3(point) => "${point} coins";

  static m4(q) => "${q}問目";

  static m5(name) => "${name} さんを紹介者として登録しますか？";

  static m6(name) => "${name} さんに10000ポイントが送られました\n自分は500ポイントゲットしました";

  static m7(clear) => "${Intl.select(clear, {'true': 'クリア', 'false': '未クリア', })}";

  static m8(title, price) => "${title} を ${price} コインで購入しますか？";

  static m9(title) => "${title}のテストを開始しますか?";

  static m10(limit) => "本日のテスト残り${limit}回";

  static m11(questions, corrects) => "${questions}問中${corrects}問正解！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appVersion" : MessageLookupByLibrary.simpleMessage("App Version"),
    "articleNotFoundMessage" : MessageLookupByLibrary.simpleMessage("記事がありません"),
    "bottomNavAgency" : MessageLookupByLibrary.simpleMessage("Agency"),
    "bottomNavColumn" : MessageLookupByLibrary.simpleMessage("Columns"),
    "bottomNavLesson" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "bottomNavMyPage" : MessageLookupByLibrary.simpleMessage("My page"),
    "bottomNavNote" : MessageLookupByLibrary.simpleMessage("Note"),
    "cancel" : MessageLookupByLibrary.simpleMessage("キャンセル"),
    "changeButtonText" : MessageLookupByLibrary.simpleMessage("変更"),
    "close" : MessageLookupByLibrary.simpleMessage("閉じる"),
    "currentPasswordHintText" : MessageLookupByLibrary.simpleMessage("現在のパスワード"),
    "darkMode" : MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "doNotEmptyMessage" : MessageLookupByLibrary.simpleMessage("入力してください"),
    "emailHintText" : MessageLookupByLibrary.simpleMessage("Email"),
    "error" : MessageLookupByLibrary.simpleMessage("エラー"),
    "errorInvalidEmail" : MessageLookupByLibrary.simpleMessage("不正なメールアドレスです"),
    "errorOperationNotAllowed" : MessageLookupByLibrary.simpleMessage("この操作は許可されていません"),
    "errorTooManyRequests" : MessageLookupByLibrary.simpleMessage("時間をおいて再試行してください"),
    "errorUndefinedError" : MessageLookupByLibrary.simpleMessage("不明なエラー"),
    "errorUserDisabled" : MessageLookupByLibrary.simpleMessage("このユーザーは現在使用できません"),
    "errorUserNotFound" : MessageLookupByLibrary.simpleMessage("ユーザーが見つかりませんでした"),
    "errorWrongPassword" : MessageLookupByLibrary.simpleMessage("パスワードが間違っています"),
    "faq" : MessageLookupByLibrary.simpleMessage("FAQ"),
    "favoritePageTitle" : MessageLookupByLibrary.simpleMessage("お気に入り"),
    "feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "getPoints" : m0,
    "havingCoin" : MessageLookupByLibrary.simpleMessage("保有しているコイン"),
    "homepage" : MessageLookupByLibrary.simpleMessage("World RIZe Website"),
    "invalidPasswordMessage" : MessageLookupByLibrary.simpleMessage("パスワードは6文字以上で入力してください"),
    "lessonPageTitle" : MessageLookupByLibrary.simpleMessage("Lesson"),
    "lessonSearchAppBarTitle" : MessageLookupByLibrary.simpleMessage("検索"),
    "lessonSearchHintText" : MessageLookupByLibrary.simpleMessage("単語など"),
    "lessonStatus" : m1,
    "license" : MessageLookupByLibrary.simpleMessage("License"),
    "memberStatus" : m2,
    "myPageInfoButton" : MessageLookupByLibrary.simpleMessage("Annoucements"),
    "myPageInfoNotFound" : MessageLookupByLibrary.simpleMessage("お知らせはありません"),
    "myPageReferFriendsButton" : MessageLookupByLibrary.simpleMessage("Refer Friends"),
    "myPageShopButton" : MessageLookupByLibrary.simpleMessage("Shop"),
    "myPageUpgradeButton" : MessageLookupByLibrary.simpleMessage("Upgrade"),
    "nameHintText" : MessageLookupByLibrary.simpleMessage("名前"),
    "newComingPageTitle" : MessageLookupByLibrary.simpleMessage("New Coming Phrases"),
    "newPasswordHintText" : MessageLookupByLibrary.simpleMessage("新しいパスワード(6文字以上)"),
    "next" : MessageLookupByLibrary.simpleMessage("次へ"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noNewComingPhraseMessage" : MessageLookupByLibrary.simpleMessage("No new coming phrases"),
    "noteList" : MessageLookupByLibrary.simpleMessage("Note List"),
    "notifications" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "onePointAdvice" : MessageLookupByLibrary.simpleMessage("One Point Advice"),
    "passwordConfirmHintText" : MessageLookupByLibrary.simpleMessage("パスワード(確認)"),
    "passwordHintText" : MessageLookupByLibrary.simpleMessage("パスワード(6文字以上)"),
    "phraseDetailTitle" : MessageLookupByLibrary.simpleMessage("Phrase Detail"),
    "points" : m3,
    "privacyPolicy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "question" : m4,
    "readMore" : MessageLookupByLibrary.simpleMessage("続きを読む"),
    "referFriendsConfirmDialog" : m5,
    "referFriendsIntroduceeIDInputTitle" : MessageLookupByLibrary.simpleMessage("紹介者のIDを入力する"),
    "referFriendsNotFound" : MessageLookupByLibrary.simpleMessage("ユーザーが見つかりませんでした"),
    "referFriendsSearchButton" : MessageLookupByLibrary.simpleMessage("検索"),
    "referFriendsSuccessDialog" : m6,
    "referFriendsTitle" : MessageLookupByLibrary.simpleMessage("Refer Friends"),
    "referFriendsUpgradeButton" : MessageLookupByLibrary.simpleMessage("友だちの紹介でアップグレードする"),
    "referFriendsUserIdHintText" : MessageLookupByLibrary.simpleMessage("ユーザーID"),
    "referFriendsYourID" : MessageLookupByLibrary.simpleMessage("あなたのID"),
    "requestPageTitle" : MessageLookupByLibrary.simpleMessage("Request"),
    "requestPhrase" : MessageLookupByLibrary.simpleMessage("フレーズのリクエスト"),
    "requestPhraseButton" : MessageLookupByLibrary.simpleMessage("フレーズをリクエストする"),
    "sectionStatus" : m7,
    "sendPhraseRequest" : MessageLookupByLibrary.simpleMessage("リクエストを送る"),
    "sendRequestButton" : MessageLookupByLibrary.simpleMessage("送る"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "shopPageConfirmDialog" : m8,
    "shopPagePurchase" : MessageLookupByLibrary.simpleMessage("購入"),
    "shopPageSuccess" : MessageLookupByLibrary.simpleMessage("交換が確定されました。2週間以内に登録されているメールアドレスにギフトコードを送信します"),
    "show30DaysChallengeAchievedDialogTitle" : MessageLookupByLibrary.simpleMessage("30 Days Challenge 達成"),
    "showQuestionnaireDialogMessage" : MessageLookupByLibrary.simpleMessage("アンケートに答えてください"),
    "showQuestionnaireDialogNg" : MessageLookupByLibrary.simpleMessage("後で"),
    "showQuestionnaireDialogOk" : MessageLookupByLibrary.simpleMessage("答える"),
    "showQuestionnaireDialogTitle" : MessageLookupByLibrary.simpleMessage("アンケートに答えてください"),
    "signInButton" : MessageLookupByLibrary.simpleMessage("ログイン"),
    "signInMessage" : MessageLookupByLibrary.simpleMessage("既にアカウントを持っている方はこちら"),
    "signInSuccessful" : MessageLookupByLibrary.simpleMessage("ログインしました"),
    "signUpButton" : MessageLookupByLibrary.simpleMessage("新しくアカウントを作成する"),
    "signUpMessage" : MessageLookupByLibrary.simpleMessage("初めての方はこちら"),
    "termsOfService" : MessageLookupByLibrary.simpleMessage("Terms of service"),
    "testClear" : MessageLookupByLibrary.simpleMessage("Test Clear!"),
    "testConfirm" : m9,
    "testInterrupt" : MessageLookupByLibrary.simpleMessage("テストを中断しますか?"),
    "testInterruptDetail" : MessageLookupByLibrary.simpleMessage("テストを中断した場合このテストは0点となり、1日のテスト受講可能回数は1回分消費されます"),
    "testLimitAlert" : MessageLookupByLibrary.simpleMessage("本日はこれ以上テストを受講することはできません"),
    "testLimitAlertDetail" : MessageLookupByLibrary.simpleMessage("テストは1日に3回まで受講することができます"),
    "testMessage" : m10,
    "testScore" : m11,
    "topPage" : MessageLookupByLibrary.simpleMessage("Go to the top page"),
    "userPageTitle" : MessageLookupByLibrary.simpleMessage("ユーザーページ"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
