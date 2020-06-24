// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/phrase/section.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_section_row.dart';

/// テスト一覧画面
///
/// 各テストに対応する [SectionRow] を列挙
class TestTab extends StatefulWidget {
  TestTab({@required this.sections, @required this.onTap});

  List<Section> sections;
  Function onTap;

  @override
  _TestTabState createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  void _showConfirmTestDialog(Section section) {
    final userStore = Provider.of<UserStore>(context, listen: false);

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testConfirm(section.title)),
        content: Text(I.of(context).testMessage(userStore.user.testLimitCount)),
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

  _onTapTestSection(Section section) {
    final userStore = Provider.of<UserStore>(context, listen: false);

    if (userStore.user.testLimitCount == 0) {
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
                child: SectionRow(
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
