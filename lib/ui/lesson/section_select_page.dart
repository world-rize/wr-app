// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/ui/lesson/phrase_list_page.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/lesson_test_page.dart';

class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

class _SectionSelectPageState extends State<SectionSelectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = [
    Tab(text: 'Lesson'),
    Tab(text: 'Test'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  void _showConfirmTestDialog(Section section) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('テストを開始しますか?'),
              content: Text('本日のテスト残り3回\n制限時間xx秒'),
              actions: <Widget>[
                CupertinoButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                CupertinoButton(
                    child: Text('YES'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => LessonTestPage(section: section)),
                      );
                    }),
              ],
            ));
  }

  Widget _createLessonSectionView(Section section) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: GFListTile(
        // left
        avatar: Text(section.title, style: TextStyle(fontSize: 28)),
        // middle
        title: Text('クリア',
            style: TextStyle(color: Colors.redAccent, fontSize: 20)),
        // right
        icon: GFButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => PhraseListPage(section: section)),
            );
          },
          child: Text('Start', style: TextStyle(fontSize: 25)),
          color: Colors.orange,
          borderShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _createTestSectionView(Section section) {
    return GestureDetector(
      onTap: () {
        _showConfirmTestDialog(section);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: GFListTile(
          // left
          avatar: Text(section.title + 'テスト', style: TextStyle(fontSize: 28)),
          // middle
          title: Text('クリア',
              style: TextStyle(color: Colors.redAccent, fontSize: 20)),
        ),
      ),
    );
  }

  Widget _createLessonView() {
    final _dummyPhrases = List<Phrase>.generate(
        10,
        (i) => Phrase(
            english: 'When is the homework due?',
            japanese: 'いつ宿題するんだっけ',
            favorite: i % 2 == 0));
    final _sections =
        List<Section>.generate(10, (i) => Section('Section $i', _dummyPhrases));

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _sections.map(_createLessonSectionView).toList(),
      ),
    );
  }

  Widget _createTestView() {
    final _dummyPhrases = List<Phrase>.generate(
        10,
        (i) => Phrase(
            english: 'When is the homework due?',
            japanese: 'いつ宿題するんだっけ',
            favorite: i % 2 == 0));
    final _sections =
        List<Section>.generate(10, (i) => Section('Section $i', _dummyPhrases));

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _sections.map(_createTestSectionView).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('School'),
            bottom: TabBar(
              tabs: _tabs,
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontSize: 20),
            )),
        body: TabBarView(
          controller: _tabController,
          children: [
            _createLessonView(),
            _createTestView(),
          ],
        ));
  }
}
