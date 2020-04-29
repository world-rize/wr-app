// Copyright © 2020 WorldRIZe. All rights reserved.

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
      body: TabBarView(
        controller: _tabController,
        children: [
          LessonView(),
          TestView(),
        ],
      ),
    );
  }
}

/// テスト一覧画面
///
/// 各レッスンに対応する [_SectionRow] を列挙
class LessonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: MasterDataStore.dummySections
            .map((section) => _SectionRow(
                  section: section,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => LessonPhrasesPage(section: section)),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}

/// テスト一覧画面
///
/// 各テストに対応する [_SectionRow] を列挙
class TestView extends StatelessWidget {
  // タップした時にダイアログを表示
  void _showConfirmTestDialog(BuildContext context, Section section) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('${section.title}のテストを開始しますか?'),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: MasterDataStore.dummySections
            .map((section) => _SectionRow(
                  section: section,
                  onTap: () {
                    _showConfirmTestDialog(context, section);
                  },
                ))
            .toList(),
      ),
    );
  }
}

/// 各セクションのタイル
class _SectionRow extends StatelessWidget {
  const _SectionRow({
    @required this.section,
    @required this.onTap,
  });

  /// 表示する Section
  final Section section;

  /// タップしたときのコールバック関数
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme;

    return GestureDetector(
      onTap: onTap,
      child: GFListTile(
        color: Colors.white,
        // left
        avatar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            section.title,
            style: style.headline.apply(color: Colors.black),
          ),
        ),
        // middle
        title: Text(
          'クリア',
          style: style.title.apply(color: Colors.redAccent),
        ),
        // right
        icon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.chevron_right,
            size: 40,
          ),
        ),
      ),
    );
  }
}
