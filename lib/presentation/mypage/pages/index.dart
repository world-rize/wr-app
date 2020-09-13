// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/mypage/pages/info_page.dart';
import 'package:wr_app/presentation/mypage/widgets/user_info.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

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
    return GestureDetector(
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
      ).padding(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).backgroundColor;

    final gridMenus = Container(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          ShadowedContainer(
            color: bg,
            child: _createIconCell(
              title: '友達紹介',
              icon: 'assets/icon/mypage_friends.png',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FriendsPage()));
              },
            ),
          ).padding(),
          ShadowedContainer(
            color: bg,
            child: _createIconCell(
              title: 'アップグレード',
              icon: 'assets/icon/mypage_upgrade.png',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => UpgradePage()));
              },
            ),
          ).padding(),
          ShadowedContainer(
            color: bg,
            child: _createIconCell(
              title: 'ショップ',
              icon: 'assets/icon/mypage_gift.png',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ShopPage()));
              },
            ),
          ).padding(),
          ShadowedContainer(
            color: bg,
            child: _createIconCell(
              title: 'お知らせ',
              icon: 'assets/icon/mypage_info.png',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => InformationPage()));
              },
            ),
          ).padding(),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserInfo().padding(),
          gridMenus,
        ],
      ).padding(),
    );
  }
}
