// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';

Widget phraseView(BuildContext context, Phrase phrase) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => LessonPhrasesDetailPage(phrase: phrase)));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GFListTile(
        title: Text(phrase.english, style: const TextStyle(fontSize: 22)),
        subtitleText: phrase.japanese,
        icon: Icon(phrase.favorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.redAccent),
      ),
    ),
  );
}
