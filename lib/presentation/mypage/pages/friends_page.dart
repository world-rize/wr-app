// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

/// mypage > index > FriendsPage
class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h5 = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('友人紹介'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '友人に紹介すると１度だけWRCoinがゲットできる！',
              style: h5,
            ),
            Text('紹介相手が有料版を購入している場合のみWRCoinが付与されます。'),
            Column(
              children: [
                Text(
                  'あなたのID',
                  style: h5,
                ),
                Text(
                  '11A22B',
                  style: h5,
                ),
                Text(
                  '紹介者のIDを入力する',
                  style: h5,
                ),
                Placeholder(
                  fallbackHeight: 80,
                ),
                Text('SNSでIDを共有する'),
                Text(
                  '11A22B',
                  style: h5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
