// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/lesson/widgets/section_select_section_row.dart';
import 'package:wr_app/model/section.dart';

/// テスト一覧画面
///
/// 各レッスンに対応する [SectionRow] を列挙
class LessonTab extends StatelessWidget {
  LessonTab({@required this.sections, @required this.onTap});

  List<Section> sections;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sections
            .map(
              (section) => SectionRow(
                section: section,
                onTap: () {
                  onTap(section);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
