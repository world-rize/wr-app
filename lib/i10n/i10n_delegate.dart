// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/widgets.dart';

import 'i10n.dart';

class IDelegate extends LocalizationsDelegate<I> {
  const IDelegate();

  @override
  bool isSupported(Locale locale) => ['ja', 'en'].contains(locale.languageCode);

  @override
  Future<I> load(Locale locale) => I.load(locale);

  @override
  bool shouldReload(IDelegate old) => false;
}
