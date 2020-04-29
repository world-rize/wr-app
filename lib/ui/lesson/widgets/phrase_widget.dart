// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';

/// フレーズを表示するコンポーネント
///
/// クリックすることで [LessonPhrasesDetailPage] へ移動
///
Widget phraseView(BuildContext context, Phrase phrase) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => LessonPhrasesDetailPage(phrase: phrase)));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GFListTile(
        title: Text(phrase.title['en'], style: const TextStyle(fontSize: 22)),
        subtitleText: phrase.title['ja'],
        icon: GestureDetector(
          onTap: () {
            // TODO
            print('favorite');
          },
          child: Icon(
            true ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent,
            size: 30,
          ),
        ),
      ),
    ),
  );
}
