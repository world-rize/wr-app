// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_section_row.dart';
import 'package:wr_app/model/section.dart';

/// テスト一覧画面
///
/// 各テストに対応する [SectionRow] を列挙
class TestTab extends StatelessWidget {
  TestTab({@required this.sections, @required this.onTap});

  List<Section> sections;
  Function onTap;

  // タップした時にダイアログを表示
  void _showConfirmTestDialog(BuildContext context, Section section) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(I.of(context).testConfirm(section.title)),
        content: Text(I.of(context).testMessage(3, 60)),
        actions: <Widget>[
          CupertinoButton(
              child: Text(I.of(context).no),
              onPressed: () {
                Navigator.pop(context);
              }),
          CupertinoButton(
            child: Text(I.of(context).yes),
            onPressed: () {
              onTap(section);
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
        children: sections
            .map((section) => SectionRow(
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
