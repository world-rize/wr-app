// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/section.dart';

import '../widgets/section_select_section_row.dart';

/// Lesson > index > lesson > sections
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
              (section) => Padding(
                padding: const EdgeInsets.all(8),
                child: SectionRow(
                  section: section,
                  onTap: () {
                    onTap(section);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
