// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/model/phrase/section.dart';

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

    return GestureDetector(
      onTap: onTap,
      child: GFListTile(
        color: Colors.white,
        // left
        avatar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            section.title,
            style: style.headline.apply(color: Colors.black),
          ),
        ),
        // middle
        title: Text(
          I.of(context).sectionStatus(true),
          style: style.title.apply(color: Colors.redAccent),
        ),
        // right
        icon: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.chevron_right,
            size: 40,
          ),
        ),
      ),
    );
  }
}
