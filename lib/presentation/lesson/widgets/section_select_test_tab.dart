// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import '../widgets/section_select_section_row.dart';

/// Lesson > index > lesson > sections
/// - enumerate sections', tests' [SectionRow]
class TestTab extends StatefulWidget {
  TestTab({@required this.sections, @required this.onTap});

  List<Section> sections;
  Function(Section) onTap;

  @override
  _TestTabState createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  void _showConfirmTestDialog(Section section) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final user = userNotifier.user;

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testConfirm(section.title)),
        content:
            Text(I.of(context).testMessage(user.testLimitCount)),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).no),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoButton(
            child: Text(I.of(context).yes),
            onPressed: () {
              widget.onTap(section);
            },
          ),
        ],
      ),
    );
  }

  void _showTestLimitAlertDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testLimitAlert),
        content: Text(I.of(context).testLimitAlertDetail),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I.of(context).ok),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _onTapTestSection(Section section) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final user = userNotifier.user;

    if (user.testLimitCount == 0) {
      _showTestLimitAlertDialog();
    } else {
      _showConfirmTestDialog(section);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.sections
            .map(
              (section) => Padding(
                padding: const EdgeInsets.all(8),
                child: TestSectionRow(
                  section: section,
                  onTap: () {
                    _onTapTestSection(section);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
