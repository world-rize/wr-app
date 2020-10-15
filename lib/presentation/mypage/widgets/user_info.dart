// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/shop_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// ユーザーの情報
class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final streaks = userNotifier.calcTestStreaks();
    final theme = Theme.of(context);
    final user = userNotifier.user;
    final items = Provider.of<ShopNotifier>(context).getShopItems();

    final badge = Padding(
      padding: const EdgeInsets.all(8),
      child: Chip(
        backgroundColor: user.isPremium ? Colors.blueAccent : Colors.grey,
        label: Text(
          I.of(context).memberStatus(user.attributes.membership),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    final bg = Theme.of(context).backgroundColor;

    return ShadowedContainer(
      color: bg,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('${user.name}', style: theme.textTheme.headline5),
                        badge,
                      ],
                    ),
                    Text(user.attributes.email,
                        style: theme.textTheme.headline6
                            .apply(color: Colors.grey)),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),

          // streak
//          StreakView().padding(),
        ],
      ),
    );
  }
}
