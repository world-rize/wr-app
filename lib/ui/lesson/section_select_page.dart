// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/store/masterdata.dart';

import 'package:wr_app/ui/lesson/lesson_phrases_page.dart';
import 'package:wr_app/ui/lesson/test_page.dart';

class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

class _LessonViewRow extends StatelessWidget {
  const _LessonViewRow({@required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: GFListTile(
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
          child: const Text('Start', style: TextStyle(fontSize: 25)),
          color: Colors.orange,
          borderShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
        children: MasterDataStore.dummySections
            .map((s) => _LessonViewRow(section: s))
            .toList(),
      ),
    );
  }
}

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
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: GFListTile(
          // left
          avatar:
              Text(section.sectionTitle, style: const TextStyle(fontSize: 28)),
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
        children: MasterDataStore.dummySections
            .map((s) => _TestViewRow(section: s))
            .toList(),
      ),
    );
  }
}

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
