// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// "()" で囲まれた部分を太字にします
/// 例 "abc(def)g" -> "abc<strong>def</strong>g"
class BoldableText extends StatelessWidget {
  BoldableText({
    required this.text,
    required this.basicStyle,
    this.hide = false,
  });

  String text;
  TextStyle basicStyle;
  bool hide;

  @override
  Widget build(BuildContext context) {
    final _children = <InlineSpan>[];
    // not good code
    text.splitMapJoin(RegExp(r'[\(（](.*)[\)）]'), onMatch: (match) {
      // blinding
      if (hide) {
        _children.add(TextSpan(
          text: ''.padLeft(text.length, '■'),
          style: basicStyle.merge(const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -10,
          )),
        ));
      } else {
        _children.add(TextSpan(
          text: match.group(1),
          style: basicStyle.merge(const TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ));
      }

      return '';
    }, onNonMatch: (plain) {
      _children.add(TextSpan(
        text: plain,
        style: basicStyle,
      ));
      return '';
    });

    return Text.rich(
      TextSpan(children: _children),
      softWrap: true,
    );
  }
}
