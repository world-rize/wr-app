// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'i10n_delegate.dart';
import 'messages.dart';
import 'messages_all.dart';

export 'messages.dart';

/// アプリでの文言はこれ経由で取得する
class I with Messages {
  /// 言語リソースを扱う
  ///
  /// localeは端末設定・アプリの指定を踏まえて最適なものが渡ってくる
  static Future<I> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    await initializeMessages(localeName);
    // デフォルト言語を設定
    Intl.defaultLocale = localeName;
    // 自身を返す
    return I();
  }

  // Widgetツリーから自身を取り出す
  static I of(BuildContext context) {
    return Localizations.of<I>(context, I);
  }

  static const LocalizationsDelegate<I> delegate = IDelegate();
}
