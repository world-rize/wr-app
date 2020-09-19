// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

/// mypage > index > UpgradePage
class UpgradePage extends StatelessWidget {
  Widget _table() {
    final rows = [
      ['xxxxx', 'xxx', 'xxx'],
      ['xxxxx', 'xxx', 'xxx'],
      ['xxxxx', 'xxx', 'xxx'],
      ['xxxxx', 'xxx', 'xxx'],
    ];

    return Table(
      columnWidths: const {
        1: FractionColumnWidth(.2),
        2: FractionColumnWidth(.2),
      },
      children: [
        ...rows.map(
          (row) => TableRow(
            children: row
                .map(
                  (c) => Text(c),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = Theme.of(context).primaryTextTheme.headline3;
    final b = Theme.of(context).primaryTextTheme.bodyText1;

    final upgradeButton = PrimaryButton(
      label: const Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
        child: Text(
          '¥0でアップグレードする',
          style: TextStyle(fontSize: 20),
        ),
      ),
      onPressed: () async {
        // TODO: call upgrade api
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('アップグレード'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'プレミアム版',
                      style: h,
                    ),
                    Text(
                      '説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。説明テキスト。',
                      style: b,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '無料版との違い',
                      style: h,
                    ),
                    const Placeholder(
                      fallbackHeight: 300,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '注意事項',
                      style: h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: upgradeButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
