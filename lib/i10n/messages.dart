// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:intl/intl.dart';
import 'package:wr_app/domain/user/model/membership.dart';

// referenced https://github.com/mono0926/intl_sample/blob/master/lib/l10n/messages.dart
mixin Messages {
  /// lesson
  String lessonStatus(int count, int all) => Intl.message(
        'クリア[$count/$all]',
        name: 'lessonStatus',
        args: [count, all],
      );

  /// phrase request
  String get requestPhraseButton => Intl.message(
        'フレーズをリクエストする',
        name: 'requestPhraseButton',
      );

  String get requestPhrase => Intl.message(
        'フレーズのリクエスト',
        name: 'requestPhrase',
      );

  /// phrase
  String get onePointAdvice => Intl.message(
        'One Point Advice',
        name: 'onePointAdvice',
      );

  String get phraseDetailTitle => Intl.message(
        'Phrase Detail',
        name: 'phraseDetailTitle',
      );

  /// point
  String points(int point) => Intl.message(
        '$point coins',
        name: 'points',
        args: [point],
      );

  /// plan
  String memberStatus(Membership membership) => Intl.select(
        membership,
        {
          Membership.normal: 'FREE',
          Membership.pro: 'PRO',
        },
        name: 'memberStatus',
        args: [membership],
      );

  /// test page
  String testConfirm(String title) => Intl.message(
        '$titleのテストを開始しますか?',
        name: 'testConfirm',
        args: [title],
      );

  String get no => Intl.message('No', name: 'no');

  String get yes => Intl.message('Yes', name: 'yes');

  String get ok => Intl.message('OK', name: 'ok');

  String testMessage(int limit) => Intl.message(
        '本日のテスト残り$limit回',
        name: 'testMessage',
        args: [limit],
      );

  String question(int q) => Intl.message(
        '$q問目',
        name: 'question',
        args: [q],
      );

  String get testLimitAlert => Intl.message(
        '本日はこれ以上テストを受講することはできません',
        name: 'testLimitAlert',
      );

  String get testLimitAlertDetail => Intl.message(
        'テストは1日に3回まで受講することができます',
        name: 'testLimitAlertDetail',
      );

  String get testInterrupt => Intl.message(
        'テストを中断しますか?',
        name: 'testInterrupt',
      );

  String get testInterruptDetail => Intl.message(
        'テストを中断した場合このテストは0点となり、1日のテスト受講可能回数は1回分消費されます',
        name: 'testInterruptDetail',
      );

  /// test result page
  String get testClear => Intl.message(
        'Test Clear!',
        name: 'testClear',
      );

  String getPoints(int point) => Intl.message(
        '$point coins Get!',
        name: 'getPoints',
        args: [point],
      );

  String get close => Intl.message(
        '閉じる',
        name: 'close',
      );

  String testScore(int questions, int corrects) => Intl.message(
        '$questions問中$corrects問正解！',
        name: 'testScore',
        args: [questions, corrects],
      );

  String get next => Intl.message(
        '次へ',
        name: 'next',
      );

  /// bottom nav bar
  String get bottomNavLesson => Intl.message(
        'Lesson',
        name: 'bottomNavLesson',
      );

  String get bottomNavColumn => Intl.message(
        'Columns',
        name: 'bottomNavColumn',
      );

  String get bottomNavNote => Intl.message(
        'Note',
        name: 'bottomNavNote',
      );

  String get bottomNavAgency => Intl.message(
        'Agency',
        name: 'bottomNavAgency',
      );

  String get bottomNavMyPage => Intl.message(
        'My page',
        name: 'bottomNavMyPage',
      );

  /// section select page
  String sectionStatus(bool clear) => Intl.select(
        clear,
        {
          true: 'クリア',
          false: '未クリア',
        },
        name: 'sectionStatus',
        args: [clear],
      );

  /// settings
  String get myPageTitle => Intl.message(
        '設定',
        name: 'myPageTitle',
      );

  String get accountSection => Intl.message(
        'アカウント',
        name: 'accountSection',
      );

  String get studySection => Intl.message(
        '学習',
        name: 'studySection',
      );

  String get otherSection => Intl.message(
        'その他',
        name: 'otherSection',
      );

  /// account page
  String get accountPageTitle => Intl.message(
        'Account',
        name: 'accountPageTitle',
      );

  /// system messages
  String get error => Intl.message(
        'エラー',
        name: 'error',
      );

  /// article
  String get articleNotFoundMessage =>
      Intl.message('記事がありません', name: 'articleNotFoundMessage');

  String get readMore => Intl.message('続きを読む', name: 'readMore');

  /// lesson
  String get lessonSearchHintText =>
      Intl.message('単語など', name: 'lessonSearchHintText');

  String get lessonSearchAppBarTitle =>
      Intl.message('検索', name: 'lessonSearchAppBarTitle');

  String get lessonPageTitle => Intl.message('Lesson', name: 'LessonPageTitle');

  String get favoritePageTitle =>
      Intl.message('お気に入り', name: 'favoritePageTitle');

  String get newComingPageTitle =>
      Intl.message('新着単語', name: 'newComingPageTitle');

  String get requestPageTitle =>
      Intl.message('Request', name: 'requestPageTitle');

  String get noNewComingPhraseMessage =>
      Intl.message('No new coming phrases', name: 'noNewComingPhraseMessage');

  String get sendPhraseRequest =>
      Intl.message('リクエストを送る', name: 'sendPhraseRequest');

  String get sendRequestButton => Intl.message('送る', name: 'sendRequestButton');

  String get showQuestionnaireDialogTitle =>
      Intl.message('アンケートに答えてください', name: 'showQuestionnaireDialogTitle');

  String get showQuestionnaireDialogMessage =>
      Intl.message('アンケートに答えてください', name: 'showQuestionnaireDialogTitle');

  String get showQuestionnaireDialogOk =>
      Intl.message('答える', name: 'showQuestionnaireDialogOk');

  String get showQuestionnaireDialogNg =>
      Intl.message('後で', name: 'showQuestionnaireDialogNg');

  String get show30DaysChallengeAchievedDialogTitle =>
      Intl.message('30 Days Challenge 達成',
          name: 'show30DaysChallengeAchievedDialogTitle');
}
