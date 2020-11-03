// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/getflutter.dart';

class Header1 extends StatelessWidget {
  const Header1({
    @required this.text,
    @required this.dividerColor,
  });

  final String text;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GFTypography(
      text: text,
      type: GFTypographyType.typo1,
      dividerColor: dividerColor,
      textColor: theme.accentColor,
    );
  }
}
