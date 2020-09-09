// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';

/// mypage > index > UpgradePage
class UpgradePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h5 = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('アップグレード'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'アップグレードでできること',
            style: h5,
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Placeholder(
              fallbackHeight: 300,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 100),
            child: Text(
              '¥0でアップグレードする',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          onPressed: () async {
            // TODO: call upgrade api
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
