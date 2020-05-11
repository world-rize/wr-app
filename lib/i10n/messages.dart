// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:intl/intl.dart';

enum Membership {
  normal,
  premium,
}

// referenced https://github.com/mono0926/intl_sample/blob/master/lib/l10n/messages.dart
mixin Messages {
  /// lesson
  String lessonStatus(int count, int all) => Intl.message(
        'クリア[$count/$all]',
        name: 'lessonStatus',
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
  String points(int point) =>
      _points(NumberFormat.compact(locale: 'en').format(point));

  String _points(String point) => Intl.message(
        '$point ポイント',
        name: 'point',
        args: [point],
      );

  /// plan
  String memberStatus(Membership membership) => Intl.select(
        membership,
        {
          Membership.normal: '通常会員です',
          Membership.premium: 'プレミアム会員です✨✨',
        },
        name: 'memberStatus',
        args: [membership],
      );

  /// test page
  String testConfirm(String title) =>
      Intl.message('$titleのテストを開始しますか?', name: 'testConfirm');

  String get no => Intl.message('No', name: 'no');

  String get yes => Intl.message('Yes', name: 'yes');

  String get ok => Intl.message('OK', name: 'ok');

  String testMessage(int limit, int time) => Intl.message(
        '本日のテスト残り$limit回\n制限時間$time秒',
        name: 'testMessage',
      );

  String question(int q) => Intl.message(
        '$q問目',
        name: 'question',
      );

  String get testInterrupt => Intl.message(
        'テストを中断しますか?',
        name: 'testInterrupt',
      );

  /// test result page
  String get testClear => Intl.message(
        'Test Clear!',
        name: 'testClear',
      );

  String getPoints(int point) => Intl.message(
        '$point ポイントGet!',
        name: 'pointGet',
      );

  String get getPiece => Intl.message(
        'ピースのカケラGet!',
        name: 'getPiece',
      );

  String get close => Intl.message(
        '閉じる',
        name: 'close',
      );

  String testScore(int questions, int corrects) => Intl.message(
        '$questions問中$corrects問正解！',
        name: 'testScore',
      );

  String testResult({bool success}) => Intl.select(
        success,
        {
          true: 'テストに合格！',
          false: 'テストに不合格...',
        },
        name: 'testResult',
        args: [success],
      );

  String get next => Intl.message(
        '次へ',
        name: 'next',
      );

  /// bottom nav bar
  String get bottomNavLesson => Intl.message(
        'Lesson',
        name: 'lesson',
      );

  String get bottomNavColumn => Intl.message(
        'Columns',
        name: 'columns',
      );

  String get bottomNavTravel => Intl.message(
        'Travel',
        name: 'travel',
      );

  String get bottomNavAgency => Intl.message(
        'Agency',
        name: 'agency',
      );

  String get bottomNavMyPage => Intl.message(
        'My page',
        name: 'mypage',
      );

  /// section select page
  String sectionStatus({bool clear}) => Intl.select(
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
        name: 'settings',
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
        name: 'account',
      );

  /// system messages
  String get error => Intl.message(
        'エラー',
        name: 'error',
      );
}
