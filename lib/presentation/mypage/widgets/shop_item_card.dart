// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/presentation/mypage/notifier/shop_page_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/sentry.dart';

/// 交換できるもののカード
class ShopItemCard extends StatelessWidget {
  const ShopItemCard({
    @required this.shopItem,
    @required this.onTap,
    @required this.gettable,
    @required this.purchasable,
    @required this.alreadyPurchased,
  });

  final ShopItem shopItem;
  final Function onTap;
  final bool gettable;
  final bool purchasable;
  final bool alreadyPurchased;

  Widget card(
    BuildContext context,
  ) {
    final backgroundColor = Theme.of(context).backgroundColor;
    final englishStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return ShadowedContainer(
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
                    if (gettable && !purchasable)
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
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context).user;
    final sn = Provider.of<ShopPageNotifier>(context);
    return purchasable && !alreadyPurchased
        ? InkWell(
            onTap: onTap,
            child: card(context),
          ).padding()
        : Opacity(
            opacity: 0.3,
            child: card(context),
          );
  }
}
// return SizedBox(
// width: MediaQuery.of(context).size.width,
// height: 100.0,
// child: Shimmer.fromColors(
// baseColor: Colors.grey[200],
// highlightColor: Colors.grey[400],
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(10)),
// color: Colors.grey[200],
// ),
// width: MediaQuery.of(context).size.width,
// height: 100,
// ),
// ),
// );
//
