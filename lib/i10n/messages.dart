// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:intl/intl.dart';
import 'package:wr_app/domain/user/model/membership.dart';

// referenced https://github.com/mono0926/intl_sample/blob/master/lib/l10n/messages.dart
mixin Messages {
  /// on_boarding
  String get signUpMessage => Intl.message('初めての方はこちら', name: 'signUpMessage');

  String get signUpButton =>
      Intl.message('新しくアカウントを作成する', name: 'signUpButton');

  String get signInMessage =>
      Intl.message('既にアカウントを持っている方はこちら', name: 'signInMessage');

  String get signInButton => Intl.message('ログイン', name: 'signInButton');

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

  String get cancel => Intl.message('キャンセル', name: 'cancel');

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

  String get lessonPageTitle => Intl.message('Lesson', name: 'lessonPageTitle');

  String get favoritePageTitle =>
      Intl.message('お気に入り', name: 'favoritePageTitle');

  String get newComingPageTitle =>
      Intl.message('New Coming Phrases', name: 'newComingPageTitle');

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
      Intl.message('アンケートに答えてください', name: 'showQuestionnaireDialogMessage');

  String get showQuestionnaireDialogOk =>
      Intl.message('答える', name: 'showQuestionnaireDialogOk');

  String get showQuestionnaireDialogNg =>
      Intl.message('後で', name: 'showQuestionnaireDialogNg');

  String get show30DaysChallengeAchievedDialogTitle =>
      Intl.message('30 Days Challenge 達成',
          name: 'show30DaysChallengeAchievedDialogTitle');

  // My page
  String get myPageReferFriendsButton =>
      Intl.message('Refer Friends', name: 'myPageReferFriendsButton');

  String get myPageUpgradeButton =>
      Intl.message('Upgrade', name: 'myPageUpgradeButton');

  String get myPageShopButton => Intl.message('Shop', name: 'myPageShopButton');

  String get myPageInfoButton =>
      Intl.message('Annoucements', name: 'myPageInfoButton');

  String get myPageInfoNotFound =>
      Intl.message('お知らせはありません', name: 'myPageInfoNotFound');

  /// 友達紹介ページ
  String get referFriendsTitle =>
      Intl.message('Refer Friends', name: 'referFriendsTitle');

  String referFriendsConfirmDialog(String name) => Intl.message(
        '$name さんを紹介者として登録しますか？',
        name: 'referFriendsConfirmDialog',
        args: [name],
      );

  String referFriendsSuccessDialog(String name) => Intl.message(
        '$name さんに10000ポイントが送られました\n自分は500ポイントゲットしました',
        name: 'referFriendsSuccessDialog',
        args: [name],
      );

  String get referFriendsUserIdHintText =>
      Intl.message('ユーザーID', name: 'referFriendsUserIdHintText');

  String get referFriendsYourID =>
      Intl.message('あなたのID', name: 'referFriendsYourID');

  String get referFriendsIntroduceeIDInputTitle =>
      Intl.message('紹介者のIDを入力する', name: 'referFriendsIntroduceeIDInputTitle');

  String get referFriendsSearchButton =>
      Intl.message('検索', name: 'referFriendsSearchButton');

  String get referFriendsNotFound =>
      Intl.message('ユーザーが見つかりませんでした', name: 'referFriendsNotFound');

  String get referFriendsUpgradeButton =>
      Intl.message('友だちの紹介でアップグレードする', name: 'referFriendsUpgradeButton');

  /// ショップページ
  String get shopPagePurchase => Intl.message('購入', name: 'shopPagePurchase');

  String shopPageConfirmDialog(String title, int price) => Intl.message(
        '$title を $price コインで購入しますか？',
        name: 'shopPageConfirmDialog',
        args: [title, price],
      );

  String get shopPageSuccess =>
      Intl.message('交換が確定されました。2週間以内に登録されているメールアドレスにギフトコードを送信します',
          name: 'shopPageSuccess');

  String get havingCoin => Intl.message('保有しているコイン', name: 'havingCoin');

  /// User page
  String get userPageTitle => Intl.message('ユーザーページ', name: 'userPageTitle');

  // Note
  String get noteList => Intl.message('Note List', name: 'noteList');

  // Settings
  String get settings => Intl.message('Settings', name: 'settings');
  String get darkMode => Intl.message('Dark Mode', name: 'darkMode');
  String get feedback => Intl.message('Feedback', name: 'feedback');
  String get notifications =>
      Intl.message('Notifications', name: 'notifications');
  String get homepage => Intl.message('World RIZe Website', name: 'homepage');
  String get faq => Intl.message('FAQ', name: 'faq');
  String get termsOfService =>
      Intl.message('Terms of service', name: 'termsOfService');
  String get privacyPolicy =>
      Intl.message('Privacy Policy', name: 'privacyPolicy');
  String get appVersion => Intl.message('App Version', name: 'appVersion');
  String get license => Intl.message('License', name: 'license');
  String get topPage => Intl.message('Go to the top page', name: 'topPage');

  String get changeButtonText => Intl.message('変更', name: 'changeButtonText');

  String get nameHintText => Intl.message('名前', name: 'nameHintText');
  String get emailHintText => Intl.message('Email', name: 'emailHintText');
  String get passwordHintText =>
      Intl.message('パスワード(6文字以上)', name: 'passwordHintText');
  String get currentPasswordHintText =>
      Intl.message('現在のパスワード', name: 'currentPasswordHintText');
  String get newPasswordHintText =>
      Intl.message('新しいパスワード(6文字以上)', name: 'newPasswordHintText');
  String get passwordConfirmHintText =>
      Intl.message('パスワード(確認)', name: 'passwordConfirmHintText');
  String get doNotEmptyMessage =>
      Intl.message('入力してください', name: 'doNotEmptyMessage');
  String get invalidPasswordMessage =>
      Intl.message('パスワードは6文字以上で入力してください', name: 'invalidPasswordMessage');

  String get signInSuccessful => Intl.message(
    'ログインしました',
    name: 'signInSuccessful'
  );

  // Firebase Auth Exception
  // 'Your email address appears to be malformed.'
  String get errorInvalidEmail =>
      Intl.message('不正なメールアドレスです', name: 'errorInvalidEmail');

  // 'Your password is wrong.'
  String get errorWrongPassword =>
      Intl.message('パスワードが間違っています', name: 'errorWrongPassword');

  // 'User with this email doesn\'t exist.'
  String get errorUserNotFound =>
      Intl.message('ユーザーが見つかりませんでした', name: 'errorUserNotFound');

  // 'User with this email has been disabled.'
  String get errorUserDisabled =>
      Intl.message('このユーザーは現在使用できません', name: 'errorUserDisabled');

  // 'Too many requests. Try again later.'
  String get errorTooManyRequests =>
      Intl.message('時間をおいて再試行してください', name: 'errorTooManyRequests');

  // 'Signing in with Email and Password is not enabled.'
  String get errorOperationNotAllowed =>
      Intl.message('この操作は許可されていません', name: 'errorOperationNotAllowed');

  // 'An undefined Error happened.'
  String get errorUndefinedError =>
      Intl.message('不明なエラー', name: 'errorUndefinedError');
}
