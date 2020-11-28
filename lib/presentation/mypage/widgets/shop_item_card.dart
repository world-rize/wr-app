// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// 交換できるもののカード
class ShopItemCard extends StatelessWidget {
  ShopItemCard({
    @required this.shopItem,
    @required this.onTap,
  });

  final ShopItem shopItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Provider.of<UserNotifier>(context).user;
    final backgroundColor = Theme.of(context).backgroundColor;
    final englishStyle = theme.primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;

    final userHasItemCount =
        user.items.containsKey(shopItem.id) ? user.items[shopItem.id] : 0;
    final gettable =
        shopItem.expendable || !shopItem.expendable && userHasItemCount == 0;
    final alreadyPurchased =
        !shopItem.expendable && user.items.containsKey(shopItem.id);
    final buyable = user.points >= shopItem.price;

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
                      shopItem.title,
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
                      '${shopItem.price} コイン',
                      style: englishStyle.apply(color: Colors.redAccent),
                    ).padding(4),
                    Text(
                      shopItem.description,
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
