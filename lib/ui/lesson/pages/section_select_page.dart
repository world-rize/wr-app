// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/user/user_notifier.dart';
import 'package:wr_app/ui/lesson/pages/section_list_page.dart';
import 'package:wr_app/ui/lesson/pages/test_page.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_lesson_tab.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_test_tab.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/toast.dart';

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
    final userStore = Provider.of<UserNotifier>(context);
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
            onTap: (Section section) {
              try {
                sendEvent(
                  event: AnalyticsEvent.visitLesson,
                  parameters: {'sectionTitle': section.title},
                );

                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => SectionListPage(section: section)),
                );
              } on Exception catch (e) {
                NotifyToast.error(e);
              }
            },
          ),
          TestTab(
            sections: sections,
            onTap: (section) async {
              try {
                await userStore.doTest();

                await sendEvent(
                  event: AnalyticsEvent.doTest,
                  parameters: {'sectionTitle': section.title},
                );

                Navigator.pop(context);

                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => TestPage(section: section)),
                );
              } on Exception catch (e) {
                NotifyToast.error(e);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
