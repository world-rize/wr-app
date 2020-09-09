// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/mypage/widgets/gift_item_card.dart';
import 'package:wr_app/presentation/user_notifier.dart';

/// ポイント交換
class ShopPage extends StatelessWidget {
  _showPurchaseConfirmDialog(BuildContext context, GiftItem item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('購入'),
        content: Text('${item.title} を ${item.price} コインで購入しますか？'),
        actions: [
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.pop(context);
              // final userNotifier = Provider.of<UserNotifier>(context, listen: false);
              // TODO: call purchase api
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final points = userNotifier.getUser().statistics.points;
    final items = [
      GiftItem(
        id: '1',
        title: 'Amazonカード 500ポイント',
        description: 'Amazonで使えるギフトカード',
        price: 5000,
        available: true,
      ),
      GiftItem(
        id: '2',
        title: 'iTunesカード 500ポイント',
        description: 'iTunesで使えるギフトカード',
        price: 5000,
        available: true,
      ),
      GiftItem(
        id: '3',
        title: 'フレーズアクセント(US)',
        description: 'USアクセント',
        price: 3000,
        available: false,
      ),
      GiftItem(
        id: '4',
        title: 'フレーズアクセント(UK)',
        description: 'USアクセント',
        price: 3000,
        available: true,
      ),
      GiftItem(
        id: '5',
        title: 'フレーズアクセント(IN)',
        description: 'INアクセント',
        price: 3000,
        available: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ショップ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('保有しているコイン'),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$points'),
                  const Text('WR coins'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('交換できるもの'),
            ),
            ...items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: GiftItemCard(
                      giftItem: item,
                      onTap: () {
                        _showPurchaseConfirmDialog(context, item);
                      },
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
