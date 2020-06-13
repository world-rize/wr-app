// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/badge/gf_badge.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/mypage/friends_page.dart';
import 'package:wr_app/ui/mypage/gift_page.dart';
import 'package:wr_app/ui/mypage/info_page.dart';
import 'package:wr_app/ui/mypage/upgrade_page.dart';

class MyPagePage extends StatelessWidget {
  Widget _cell({
    @required String title,
    @required Icon icon,
    @required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
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
            title: Row(
              children: [
                Text('${userStore.user.name} さん'),
                if (userStore.isPremium)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: GFBadge(
                      color: Colors.redAccent,
                      child: Text('pro'),
                      shape: GFBadgeShape.pills,
                    ),
                  ),
              ],
            ),
            subtitleText: userStore.user.email,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: GFListTile(
            titleText: 'テスト本日残り${userStore.user.testLimitCount} 回',
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
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => InformationPage()));
                },
              ),
              _cell(
                title: '友達紹介',
                icon: const Icon(
                  Icons.email,
                  size: 60,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FriendsPage()));
                },
              ),
              _cell(
                title: '有料版購入',
                icon: const Icon(
                  Icons.email,
                  size: 60,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => UpgradePage()));
                },
              ),
              _cell(
                title: 'WR coins交換',
                icon: const Icon(
                  Icons.email,
                  size: 60,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => GiftPage()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
