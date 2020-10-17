// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/loading_view.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/toast.dart';

import './section_list_page.dart';
import './test_page.dart';
import '../widgets/section_select_lesson_tab.dart';
import '../widgets/section_select_test_tab.dart';

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
  bool _isLoading;

  /// タブ
  TabController _tabController;
  final List<Tab> _tabs = [
    const Tab(text: 'Lesson'),
    const Tab(text: 'Test'),
  ];

  Future _doLesson(Section section) async {
    try {
      await sendEvent(
        event: AnalyticsEvent.visitLesson,
        parameters: {'sectionTitle': section.title},
      );

      await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SectionListPage(section: section)));
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  // テスト受講
  Future _doTest(Section section) async {
    final un = Provider.of<UserNotifier>(context, listen: false);

    try {
      // ダイアログ一回のみ
      Navigator.of(context).pop();
      setState(() {
        _isLoading = true;
      });
      await un.doTest(sectionId: section.title);

      await sendEvent(
        event: AnalyticsEvent.doTest,
        parameters: {'sectionTitle': section.title},
      );

      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TestPage(section: section)),
      );
    } on Exception catch (e) {
      NotifyToast.error(e);
      Navigator.pop(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final sections = Section.fromLesson(lesson);
    final primaryColor = Theme.of(context).primaryColor;

    return LoadingView(
      loading: _isLoading,
      child: Scaffold(
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
              onTap: _doLesson,
            ),
            TestTab(
              sections: sections,
              onTap: _doTest,
            ),
          ],
        ),
      ),
    );
  }
}
