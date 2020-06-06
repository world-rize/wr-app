// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/section_list_page.dart';
import 'package:wr_app/ui/lesson/test_page.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_lesson_tab.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_test_tab.dart';

/// セクション選択画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469132>
class SectionSelectPage extends StatefulWidget {
  const SectionSelectPage({@required this.lesson});

  final Lesson lesson;

  @override
  _SectionSelectPageState createState() =>
      _SectionSelectPageState(lesson: lesson);
}

/// セクション選択画面
/// [SectionSelectPage] の State
///
/// [LessonTab] レッスン一覧画面
/// [TestTab] テスト一覧画面
class _SectionSelectPageState extends State<SectionSelectPage>
    with SingleTickerProviderStateMixin {
  _SectionSelectPageState({@required this.lesson});

  ///レッスン
  final Lesson lesson;

  /// タブ
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
    final sections = Section.fromLesson(lesson);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(lesson.title['ja'],
            style: const TextStyle(color: Colors.white)),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          indicatorColor: Colors.orange,
          indicatorWeight: 3,
          labelColor: Colors.white,
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
                    builder: (_) => SectionListPage(section: section)),
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
