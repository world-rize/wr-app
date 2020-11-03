// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/section.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// 各テストセクションのタイル
class TestSectionRow extends StatelessWidget {
  const TestSectionRow({
    required this.section,
    required this.onTap,
  });

  /// 表示する Section
  final Section section;

  /// タップしたときのコールバック関数
  final void Function() onTap;

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

/// 各セクションのタイル
class SectionRow extends StatelessWidget {
  const SectionRow({
    required this.section,
    required this.onTap,
  });

  /// 表示する Section
  final Section section;

  /// タップしたときのコールバック関数
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme;
    final backgroundColor = Theme.of(context).backgroundColor;

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
