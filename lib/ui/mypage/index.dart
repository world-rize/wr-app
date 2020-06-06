// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';

class MyPagePage extends StatelessWidget {
  Widget _cell({
    @required String title,
    @required Icon icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: icon,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: GFListTile(
            avatar: const GFAvatar(),
            titleText: '${userStore.user.name} さん',
            subtitleText: userStore.user.email,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: GFListTile(
            titleText: 'テスト本日残り${userStore.user.testLimitCount} 回',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: GFListTile(
            titleText: 'レッスン別達成率: xxx %',
          ),
        ),
        Expanded(
          child: GridView.count(
            // physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: [
              _cell(
                  title: 'お知らせ',
                  icon: const Icon(
                    Icons.email,
                    size: 60,
                  )),
              _cell(
                  title: '友達紹介',
                  icon: const Icon(
                    Icons.email,
                    size: 60,
                  )),
              _cell(
                  title: 'ポイント交換',
                  icon: const Icon(
                    Icons.email,
                    size: 60,
                  )),
              _cell(
                  title: 'HP',
                  icon: const Icon(
                    Icons.email,
                    size: 60,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
