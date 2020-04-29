// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:wr_app/model/phrase.dart';

/// セクション: フレーズの集まり
class Section {
  Section({
    @required this.title,
    @required this.phrases,
  });

  final String title;

  /// list of phrase
  final List<Phrase> phrases;
}
