// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/mypage/pages/friends.dart';
import 'package:wr_app/ui/widgets/block.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

/// mypage > index > UpgradePage
class UpgradePage extends StatelessWidget {
  Widget _table() {
    final rows = [
      ['', 'Free', 'Pro'],
      ['Lessonフレーズ', '各カテゴリー7問', '640+'],
      ['Request', '❌', '⭕'],
      ['WR Coin交換', '❌', '⭕'],
      ['30 days bonus', '❌', '⭕'],
      ['Note Fileの数', '最大1個', '最大3個'],
      ['広告', '⭕', '❌'],
    ];

    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey[400], width: 0.5)),
      columnWidths: const {
        1: FractionColumnWidth(.3),
        2: FractionColumnWidth(.3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        ...rows.map(
          (row) => TableRow(
            children: row
                .map(
                  (c) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(c),
                  ),
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

    const upgradeButton = PrimaryButton(
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 100),
        child: Text(
          'アップグレードする',
          style: TextStyle(fontSize: 20),
        ),
      ),
//        () async {
//        // TODO: call upgrade api
//      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(I.of(context).myPageUpgradeButton),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8).add(EdgeInsets.only(bottom: 90)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Block(
                children: [
                  Text(
                    'PRO版',
                    style: h,
                  ),
                  Text.rich(
                    TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: '※WR英会話をアップグレードしてみよう！\nアップグレードをすると',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Block(
                children: [
                  Text(
                    '無料版との違い',
                    style: h,
                  ),
                  _table(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text: 'さらに招待コードを入力で双方にWR coinをプレゼントします！詳しくは',
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                          TextSpan(
                            text: 'こちら',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => FriendsPage()));
                              },
                            style: b.apply(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Block(
                children: [
                  Text(
                    '注意事項',
                    style: h,
                  ),
                  Text(
                    '一度アップデートをしたら返金は行っていませんのでご了承ください\n詳しくはFAQのUpgradeについてをご確認ください',
                    style: b,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(16),
        child: upgradeButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
