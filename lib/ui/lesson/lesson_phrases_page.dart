// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';

import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

/// フレーズ一覧ページ
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469136>
class LessonPhrasesPage extends StatelessWidget {
  const LessonPhrasesPage({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(section.title),
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
                  style: style.display1.apply(color: Colors.black),
                ),
                title: Text(
                  '未クリア',
                  style: style.title.apply(color: Colors.redAccent),
                ),
              ),
            ),
            // フレーズ一覧
            ...section.phrases.map((phrase) {
              return phraseView(context, phrase);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
