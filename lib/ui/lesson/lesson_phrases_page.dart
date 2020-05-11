// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';

import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

/// フレーズ一覧ページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469136>
class LessonPhrasesPage extends StatelessWidget {
  const LessonPhrasesPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          section.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      // TODO(somebody): per-page scroll physics
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ヘッダ
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: GFListTile(
                avatar: Text(
                  section.title,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                title: Text(
                  '未クリア',
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
              ),
            ),
            // フレーズ一覧
            ...section.phrases.map((phrase) {
              return phraseView(context, phrase, onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LessonPhrasesDetailPage(phrase: phrase),
                ));
              });
            }).toList(),
          ],
        ),
      ),
    );
  }
}
