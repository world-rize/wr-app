// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/user_notifier.dart';

import './friends_page.dart';
import './gift_page.dart';
import './upgrade_page.dart';

/// mypage > index
class MyPagePage extends StatelessWidget {
  Widget _menuCell({
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
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserNotifier>(context);

    final userInfo = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Text('${userStore.getUser().name} さん'),
                if (userStore.getUser().isPremium)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: GFBadge(
                      color: Colors.redAccent,
                      child: Text('pro'),
                      shape: GFBadgeShape.pills,
                    ),
                  ),
                Text(userStore.getUser().email),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(Icons.attach_money),
                Text(I.of(context).points(userStore.getUser().point)),
              ],
            ),
          )
        ],
      ),
    );

    final gridMenus = GridView.count(
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      children: [
        _menuCell(
          title: '友達紹介',
          icon: const Icon(
            Icons.email,
            color: Colors.blueGrey,
            size: 40,
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FriendsPage()));
          },
        ),
        _menuCell(
          title: '有料版購入',
          icon: const Icon(
            Icons.email,
            color: Colors.blueGrey,
            size: 40,
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UpgradePage()));
          },
        ),
        _menuCell(
          title: '交換',
          icon: const Icon(
            Icons.email,
            color: Colors.blueGrey,
            size: 40,
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => GiftPage()));
          },
        ),
      ],
    );

//    final settings = SettingsList(
//      sections: [
//        SettingsSection(
//          title: '設定',
//          tiles: [
//            SettingsTile(
//              title: 'ユーザー設定',
//              leading: const Icon(Icons.notifications),
//              onTap: () {},
//            )
//          ],
//        ),
//      ],
//    );
    final settings = Placeholder(
      fallbackHeight: 100,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: userInfo,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: gridMenus,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: settings,
        ),
      ],
    );
  }
}
