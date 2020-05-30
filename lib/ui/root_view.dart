// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/agency/index.dart';
import 'package:wr_app/ui/column/index.dart';
import 'package:wr_app/ui/lesson/index.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_search_iconbutton.dart';
import 'package:wr_app/ui/mypage/index.dart';
import 'package:wr_app/ui/onboarding/index.dart';
import 'package:wr_app/ui/settings/index.dart';
import 'package:wr_app/ui/travel/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/extension/padding_extension.dart';

/// 全ての画面のガワ
///
/// 検索ボックス等
class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

/// [RootView] state
class _RootViewState extends State<RootView>
    with SingleTickerProviderStateMixin {
  int _index;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _index = 0;
    // init controller
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final firstLaunch = UserStore().firstLaunch;
      print('first launch: $firstLaunch');

      // show on boarding modal
      if (firstLaunch) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OnBoardModal(),
            fullscreenDialog: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final primaryColor = Theme.of(context).primaryColor;

    final header = Row(
      children: <Widget>[
        SvgPicture.asset(
          'assets/icon/wr_coin.svg',
        ).p_1(),
        Text(
          I.of(context).points(userStore.user.point),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );

    final actions = <Widget>[
      // phrase search
      PhraseSearchIconButton(),
      // settings
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SettingsPage(),
            fullscreenDialog: true,
          ));
        },
      )
    ];

    final navbar = BottomNavigationBar(
      fixedColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        _pageController.jumpToPage(index);
//          _pageController.animateToPage(index,
//              duration: const Duration(milliseconds: 300), curve: Curves.ease);
      },
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.create),
          title: Text(I.of(context).bottomNavLesson),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.view_column),
          title: Text(I.of(context).bottomNavColumn),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.airplanemode_active),
          title: Text(I.of(context).bottomNavTravel),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.public),
          title: Text(I.of(context).bottomNavAgency),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          title: Text(I.of(context).bottomNavMyPage),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: header,
        actions: actions,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        children: <Widget>[
          LessonIndexPage(),
          ColumnIndexPage(),
          TravelPage(),
          AgencyIndexPage(),
          MyPagePage(),
        ],
      ),
      bottomNavigationBar: navbar,
    );
  }
}
