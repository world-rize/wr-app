// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/store/masterdata.dart';

import 'package:wr_app/ui/lesson/lesson_phrases_page.dart';
import 'package:wr_app/ui/lesson/test_page.dart';

/// セクション選択画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469132>
class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

/// セクション選択画面
/// [SectionSelectPage] の State
///
/// [LessonView] レッスン一覧画面
/// [TestView] テスト一覧画面
class _SectionSelectPageState extends State<SectionSelectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: 'Lesson'),
    const Tab(text: 'Test'),
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
        title: const Text('School'),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          indicatorColor: Colors.orange,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontSize: 20),
        ),
      ),
      body: Provider<MasterDataStore>(
        create: (_) => MasterDataStore(),
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

/// テスト一覧画面
///
/// 各レッスンに対応する [_LessonViewRow] を列挙
class LessonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _bgColor = Color.fromARGB(255, 230, 230, 230);

    return Container(
      decoration: const BoxDecoration(color: _bgColor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: MasterDataStore.dummySections
              .map((s) => _LessonViewRow(section: s))
              .toList(),
        ),
      ),
    );
  }
}

/// テスト一覧画面
///
/// 各テストに対応する [_TestViewRow] を列挙
class TestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _bgColor = Color.fromARGB(255, 230, 230, 230);

    return Container(
      decoration: const BoxDecoration(color: _bgColor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: MasterDataStore.dummySections
              .map((s) => _TestViewRow(section: s))
              .toList(),
        ),
      ),
    );
  }
}

/// レッスン
class _LessonViewRow extends StatelessWidget {
  const _LessonViewRow({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GFListTile(
        color: Colors.white,
        // left
        avatar:
            Text(section.sectionTitle, style: const TextStyle(fontSize: 28)),
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Start', style: TextStyle(fontSize: 25)),
          ),
          color: Colors.orange,
          borderShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}

/// テスト
class _TestViewRow extends StatelessWidget {
  const _TestViewRow({@required this.section});
  final Section section;

  void _showConfirmTestDialog(BuildContext context, Section section) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('テストを開始しますか?'),
        content: const Text('本日のテスト残り3回\n制限時間xx秒'),
        actions: <Widget>[
          CupertinoButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.pop(context);
              }),
          CupertinoButton(
            child: const Text('YES'),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GFListTile(
          color: Colors.white,
          // left
          avatar: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(section.sectionTitle,
                style: const TextStyle(fontSize: 28)),
          ),
          // middle
          title: Text('クリア',
              style: TextStyle(color: Colors.redAccent, fontSize: 20)),
        ),
      ),
    );
  }
}
