// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/theme.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';

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

  return Padding(
    padding: const EdgeInsets.all(8),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        phrase.title['en'],
                        style: englishStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        phrase.title['ja'],
                        style: japaneseStyle,
                      ),
                    )
                  ],
                ),
              ),
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
    ),
  );
}
