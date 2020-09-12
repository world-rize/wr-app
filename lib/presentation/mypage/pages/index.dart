// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/mypage/pages/info_page.dart';
import 'package:wr_app/presentation/mypage/widgets/user_info.dart';

import './friends_page.dart';
import './shop_page.dart';
import './upgrade_page.dart';

/// mypage > index
class MyPagePage extends StatelessWidget {
  Widget _createIconCell({
    @required String title,
    @required String icon,
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
              child: Image.asset(icon),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gridMenus = GridView.count(
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: [
        _createIconCell(
          title: '友達紹介',
          icon: 'assets/icon/mypage_friends.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FriendsPage()));
          },
        ),
        _createIconCell(
          title: 'アップグレード',
          icon: 'assets/icon/mypage_upgrade.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UpgradePage()));
          },
        ),
        _createIconCell(
          title: 'ショップ',
          icon: 'assets/icon/mypage_gift.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ShopPage()));
          },
        ),
        _createIconCell(
          title: 'お知らせ',
          icon: 'assets/icon/mypage_info.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => InformationPage()));
          },
        ),
      ],
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: UserInfo(),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: gridMenus,
          ),
        ],
      ),
    );
  }
}
