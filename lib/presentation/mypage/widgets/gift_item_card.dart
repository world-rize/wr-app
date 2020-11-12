// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// 交換できるもののカード
class GiftItemCard extends StatelessWidget {
  GiftItemCard({
    @required this.giftItem,
    @required this.onTap,
  });

  final ShopItem giftItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Provider.of<UserNotifier>(context).user;
    final backgroundColor = Theme.of(context).backgroundColor;
    final englishStyle = theme.primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;

    final userHasItemCount =
        user.items.containsKey(giftItem.id) ? user.items[giftItem.id] : 0;
    final gettable =
        giftItem.expendable || !giftItem.expendable && userHasItemCount == 0;
    final alreadyPurchased =
        !giftItem.expendable && user.items.containsKey(giftItem.id);
    final buyable = user.statistics.points >= giftItem.price;

    final card = ShadowedContainer(
      color: backgroundColor,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      giftItem.title,
                      style: englishStyle,
                    ).padding(4),
                    if (gettable && !buyable)
                      Text(
                        'WRコインが不足しています',
                        style: englishStyle.apply(color: Colors.redAccent),
                      ).padding(4),
                    if (alreadyPurchased)
                      Text(
                        'すでに持っています',
                        style: englishStyle.apply(color: Colors.redAccent),
                      ).padding(4),
                    Text(
                      '${giftItem.price} コイン',
                      style: englishStyle.apply(color: Colors.redAccent),
                    ).padding(4),
                    Text(
                      giftItem.description,
                      style: japaneseStyle,
                    ).padding(4),
                  ],
                ).padding(),
              ),
            ),
          ],
        ),
      ),
    );

    return buyable && !alreadyPurchased
        ? InkWell(
            onTap: onTap,
            child: card,
          ).padding()
        : Opacity(
            opacity: 0.3,
            child: card,
          );
  }
}
