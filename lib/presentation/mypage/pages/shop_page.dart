// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/mypage/notifier/shop_notifier.dart';
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
              final userNotifier =
                  Provider.of<UserNotifier>(context, listen: false);
              await userNotifier.purchaseItem(itemId: item.id);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shopNotifier = Provider.of<ShopNotifier>(context);
    final userNotifier = Provider.of<UserNotifier>(context);
    final points = userNotifier.getUser().statistics.points;

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
            FutureBuilder<List<GiftItem>>(
              future: shopNotifier.getShopItems(),
              builder: (_, ss) {
                if (!ss.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Column(
                    children: ss.data
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
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
