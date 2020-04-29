// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/model/section.dart';
import 'package:wr_app/store/masterdata.dart';

import 'package:wr_app/ui/lesson/lesson_phrases_page.dart';
import 'package:wr_app/ui/lesson/test_page.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_lesson_tab.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_test_tab.dart';

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
/// [LessonTab] レッスン一覧画面
/// [TestTab] テスト一覧画面
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
    final sections = MasterDataStore.dummySections;

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
          LessonTab(
            sections: sections,
            onTap: (section) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => LessonPhrasesPage(section: section)),
              );
            },
          ),
          TestTab(
            sections: sections,
            onTap: (section) {
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
}
