// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/theme.dart';
import 'package:wr_app/extension/string_capitalization.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/extension/padding_extension.dart';

/// フレーズを表示するコンポーネント
///
/// クリックすることで [LessonPhrasesDetailPage] へ移動
///
Widget phraseView(BuildContext context, Phrase phrase, {Function onTap}) {
  assert(phrase != null);
  final userStore = Provider.of<UserStore>(context);
  final favorite = userStore.user.favorites.containsKey(phrase.id) &&
      userStore.user.favorites[phrase.id];
  final englishStyle = wrThemeData.primaryTextTheme.bodyText1;
  final japaneseStyle = wrThemeData.primaryTextTheme.bodyText2;
  // TODO: debug
  final existVoice = phrase.assets.voice.isEmpty;

  return GestureDetector(
    onTap: onTap,
    child: ShadowedContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  (existVoice ? '[x]' : '') + phrase.title['en'].capitalize(),
                  style: englishStyle,
                ).p(4),
                Text(
                  phrase.title['ja'],
                  style: japaneseStyle,
                ).p(4),
              ],
            ).p_1(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14, bottom: 14),
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
              size: 24,
            ),
          ),
        ],
      ),
    ),
  ).p_1();
}
