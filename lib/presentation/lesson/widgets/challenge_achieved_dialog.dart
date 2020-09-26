// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

class ChallengeAchievedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(I.of(context).show30DaysChallengeAchievedDialogTitle),
      content: Column(
        children: [
          const Center(
            child: Text('Congratulations!'),
          ),
          Text(I.of(context).show30DaysChallengeAchievedDialogTitle),
          Row(
            children: [],
          ),
          const Text('30 Days Challenge 達成'),
          PrimaryButton(
            label: const Text('追加するアクセントを選ぶ'),
            onPressed: () {
              // TODO: Go to "addAccentPage"
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Ok'),
          onPressed: () async {},
        ),
      ],
    );
  }
}
