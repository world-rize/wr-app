// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/user_notifier.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final theme = Theme.of(context);
    final user = userNotifier.getUser();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${user.name}', style: theme.textTheme.headline5),
                if (user.isPremium)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: GFBadge(
                      color: Colors.redAccent,
                      child: Text('pro'),
                      shape: GFBadgeShape.pills,
                    ),
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
    );
  }
}
