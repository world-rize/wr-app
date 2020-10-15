// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/lesson.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/analytics.dart';
import 'package:wr_app/util/toast.dart';

import './phrase_list_page.dart';
import './test_page.dart';
import '../widgets/section_select_lesson_tab.dart';
import '../widgets/section_select_test_tab.dart';

/// セクション選択画面
///
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469132>
class SectionSelectPageModel extends ChangeNotifier {
  SectionSelectPageModel({@required this.lesson}) : _isLoading = false;

  final Lesson lesson;

  get sections => Section.fromLesson(lesson);
  bool _isLoading;

  Future onTapLessonCard(BuildContext context, Section section) async {
    try {
      await sendEvent(
        event: AnalyticsEvent.visitLesson,
        parameters: {'sectionTitle': section.title},
      );

      await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PhraseListPage(section: section)));
    } on Exception catch (e) {
      NotifyToast.error(e);
    }
  }

  Future onTapTestCard(BuildContext context, Section section) async {
    final un = context.read<UserNotifier>();

    try {
      // ダイアログ一回のみ
      Navigator.of(context).pop();
      _isLoading = true;
      notifyListeners();
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
      _isLoading = false;
    }
  }
}

class SectionSelectPage extends StatelessWidget {
  const SectionSelectPage({@required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SectionSelectPageModel(lesson: lesson),
      child: _SectionSelectPage(),
    );
  }
}

/// セクション選択画面
/// [SectionSelectPage] の State
///
/// [LessonTab] レッスン一覧画面
/// [TestTab] テスト一覧画面
class _SectionSelectPage extends StatelessWidget {
  /// タブ
  final List<Tab> _tabs = [
    const Tab(text: 'Lesson'),
    const Tab(text: 'Test'),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SectionSelectPageModel>();
    final primaryColor = Theme.of(context).primaryColor;

    return DefaultTabController(
      length: _tabs.length,
      child: LoadingView(
        loading: state._isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(state.lesson.title['ja'],
                style: const TextStyle(color: Colors.white)),
            bottom: TabBar(
              tabs: _tabs,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 20),
            ),
          ),
          body: TabBarView(
            children: [
              LessonTab(
                sections: state.sections,
                onTap: (section) => state.onTapLessonCard(context, section),
              ),
              TestTab(
                sections: state.sections,
                onTap: (section) => state.onTapTestCard(context, section),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
