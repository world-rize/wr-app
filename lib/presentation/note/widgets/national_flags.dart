// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// 国旗
class NationalFlags extends StatelessWidget {
  NationalFlags({
    @required this.locales,
    @required this.locale,
    @required this.onChanged,
  });

  final List<String> locales;
  final String locale;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: locales
          .map((l) => Expanded(
                flex: 1,
                child: FlatButton(
                  onPressed: () {
                    onChanged(l);
                  },
                  child: Container(
                    decoration: locale == l
                        ? BoxDecoration(border: Border.all())
                        : null,
                    child: Image.asset(
                      'assets/icon/locale_$locale.png',
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
