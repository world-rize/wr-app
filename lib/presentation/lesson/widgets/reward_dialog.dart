// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/i10n/i10n.dart';

class RewardDialog extends StatelessWidget {
  const RewardDialog({this.text, this.onTap});

  final Widget text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(I.of(context).testClear),
      content: Column(
        children: <Widget>[
          text,
          GFButton(
            color: Colors.orange,
            text: I.of(context).close,
            size: GFSize.LARGE,
            shape: GFButtonShape.pills,
            padding: const EdgeInsets.symmetric(horizontal: 80),
            onPressed: onTap,
          )
        ],
      ),
    );
  }
}
