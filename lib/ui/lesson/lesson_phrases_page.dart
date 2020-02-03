// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/lesson/lesson_phrases_detail_page.dart';

class PhraseListPage extends StatelessWidget {
  final Section section;

  PhraseListPage({this.section});

  Widget _createHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: GFListTile(
        avatar: Text(section.title, style: TextStyle(fontSize: 30)),
        title: Text('未クリア',
            style: TextStyle(fontSize: 20, color: Colors.redAccent)),
      ),
    );
  }

  List<Widget> _createPhraseList(BuildContext context) {
    return section.phrases
        .map((phrase) => PhraseView(context, phrase))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(section.title),
      ),
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
