// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';

import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

class LessonPhrasesPage extends StatelessWidget {
  const LessonPhrasesPage({@required this.section});

  final Section section;

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: GFListTile(
        // color: Colo,
        avatar:
            Text(section.sectionTitle, style: const TextStyle(fontSize: 30)),
        title: Text('未クリア',
            style: TextStyle(fontSize: 20, color: Colors.redAccent)),
      ),
    );
  }

  List<Widget> _createPhraseList(BuildContext context) {
    return section.phrases
        .map((phrase) => phraseView(context, phrase))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(section.sectionTitle),
      ),
      // TODO(somebody): per-page scroll physics
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _createHeader(),
            ..._createPhraseList(context),
          ],
        ),
      ),
    );
  }
}
