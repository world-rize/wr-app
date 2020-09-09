// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/user_notifier.dart';

/// ユーザーの情報
class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final streaks = userNotifier.calcTestStreaks();
    final theme = Theme.of(context);
    final user = userNotifier.getUser();

    final streaksStatus = Text('streaks $streaks / 30');
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

    return Container(
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
                    Text(user.attributes.email),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.attach_money),
                    Text(I.of(context).points(user.statistics.points)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: streaksStatus,
          ),
        ],
      ),
    );
  }
}
