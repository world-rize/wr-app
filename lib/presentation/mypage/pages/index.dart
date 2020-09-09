// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/presentation/mypage/pages/archived_list_page.dart';
import 'package:wr_app/presentation/mypage/pages/info_page.dart';
import 'package:wr_app/presentation/mypage/pages/locale_page.dart';
import 'package:wr_app/presentation/mypage/widgets/user_info.dart';

import './friends_page.dart';
import './shop_page.dart';
import './upgrade_page.dart';

/// mypage > index
class MyPagePage extends StatelessWidget {
  Widget _menuCell({
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
      crossAxisCount: 3,
      children: [
        _menuCell(
          title: '友達紹介',
          icon: 'assets/icon/mypage_friends.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FriendsPage()));
          },
        ),
        _menuCell(
          title: 'アップグレード',
          icon: 'assets/icon/mypage_upgrade.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UpgradePage()));
          },
        ),
        _menuCell(
          title: '交換',
          icon: 'assets/icon/mypage_gift.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ShopPage()));
          },
        ),
        _menuCell(
          title: 'アクセント追加',
          icon: 'assets/icon/mypage_locale.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LocalePage()));
          },
        ),
        _menuCell(
          title: 'Archived List',
          icon: 'assets/icon/mypage_archive.png',
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ArchivedListPage()));
          },
        ),
        _menuCell(
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
