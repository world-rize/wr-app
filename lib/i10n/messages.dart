// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:intl/intl.dart';

enum Membership {
  normal,
  premium,
}

// referenced https://github.com/mono0926/intl_sample/blob/master/lib/l10n/messages.dart
mixin Messages {
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
}
