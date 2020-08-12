// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/logger.dart';

/// mypage > index > ArchivedList
class ArchivedListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final user = userNotifier.getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('アーカイブ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('アーカイブ'),
            Text('statistics'),
            Text(InAppLogger.prettify(user.statistics.toJson())),
            Text('favorites'),
            ...user.favorites.values
                .map((list) => Text(InAppLogger.prettify(list.toJson()))),
            Text('notes'),
            ...user.notes.values
                .map((list) => Text(InAppLogger.prettify(list.toJson()))),
            Text('activities'),
            ...user.activities.map(
                (activity) => Text(InAppLogger.prettify(activity.toJson())))
          ],
        ),
      ),
    );
  }
}
