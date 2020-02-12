// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/model/phrase.dart';

import 'package:wr_app/store/sample_store.dart';

import 'package:wr_app/ui/lesson/lesson_phrases_page.dart';
import 'package:wr_app/ui/lesson/test_page.dart';

class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

class _LessonViewRow extends StatelessWidget {
  final Section section;

  _LessonViewRow({this.section});

  @override
  Widget build(BuildContext context) {
    // TODO stateful widget
    assert(section.title != null);

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
                  builder: (_) => LessonPhrasesPage(section: section)),
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
}

class LessonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            dummySections().map((s) => _LessonViewRow(section: s)).toList(),
      ),
    );
  }
}

class _TestViewRow extends StatelessWidget {
  final Section section;
  _TestViewRow({this.section});

  void _showConfirmTestDialog(BuildContext context, Section section) {
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
                MaterialPageRoute(builder: (_) => TestPage(section: section)),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showConfirmTestDialog(context, section);
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
}

class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: dummySections().map((s) => _TestViewRow(section: s)).toList(),
      ),
    );
  }
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
        ),
      ),
      body: Provider<SampleStore>(
        create: (_) => SampleStore(),
        child: TabBarView(
          controller: _tabController,
          children: [
            LessonView(),
            TestView(),
          ],
        ),
      ),
    );
  }
}
