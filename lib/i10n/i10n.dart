// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'i10n_delegate.dart';
import 'messages.dart';
import 'messages_all.dart';

export 'messages.dart';
// see <https://medium.com/flutter-jp/intl-beb5b9e8ee73>

/// i10n object
class I with Messages {
  /// locale
  static Future<I> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    await initializeMessages(localeName);
    Intl.defaultLocale = localeName;
    return I();
  }

  static I of(BuildContext context) {
    return Localizations.of<I>(context, I);
  }

  static const LocalizationsDelegate<I> delegate = IDelegate();
}
