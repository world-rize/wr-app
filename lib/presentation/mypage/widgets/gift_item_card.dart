// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// 交換できるもの
class GiftItem {
  GiftItem({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.available,
  });

  /// id
  String id;

  /// ギフト名
  String title;

  /// 説明
  String description;

  /// 価格
  int price;

  /// 購入可能か
  bool available;
}

/// 交換できるもののカード
class GiftItemCard extends StatelessWidget {
  GiftItemCard({
    @required this.giftItem,
    @required this.onTap,
  });

  final GiftItem giftItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = Theme.of(context).backgroundColor;
    final englishStyle = theme.primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;

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
                    ).p(4),
                    Text(
                      '${giftItem.price} コイン',
                      style: englishStyle.apply(color: Colors.redAccent),
                    ).p(4),
                    Text(
                      giftItem.description,
                      style: japaneseStyle,
                    ).p(4),
                  ],
                ).p_1(),
              ),
            ),
          ],
        ),
      ),
    );

    return giftItem.available
        ? InkWell(
            onTap: onTap,
            child: card,
          ).p_1()
        : Opacity(
            opacity: 0.3,
            child: card,
          );
  }
}
