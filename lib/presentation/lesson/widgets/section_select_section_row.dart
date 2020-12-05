// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/lesson/pages/section_list_page.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/section_page.dart';
import 'package:wr_app/presentation/lesson/widgets/phrases_container.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// 各テストセクションのタイル
class TestSectionRow extends StatelessWidget {
  const TestSectionRow({
    @required this.section,
    @required this.onTap,
  });

  /// 表示する Section
  final Section section;

  /// タップしたときのコールバック関数
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme;
    final backgroundColor = Theme.of(context).backgroundColor;
    final currentScore = Provider.of<UserNotifier>(context)
        .getHighestScore(sectionId: section.id);

    final sectionWidget = ShadowedContainer(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  section.title,
                  style: style.headline2,
                ),
              ),
            ),
            Text(
              '$currentScore/${section.phrases.length}',
              style: style.bodyText1.apply(color: Colors.redAccent),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.chevron_right,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: sectionWidget,
    );
  }
}

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

/// 各セクションのタイル
class SectionRow extends StatelessWidget {
  const SectionRow({
    @required this.section,
    @required this.onTap,
  });

  /// 表示する Section
  final Section section;

  /// タップしたときのコールバック関数
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme;
    final backgroundColor = Theme.of(context).backgroundColor;

    final header = Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                section.title,
                style: style.headline2,
              ),
            ),
          ),
        ],
      ),
    );

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: header,
                  collapsed: null,
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PhrasesContainer(section: section),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
