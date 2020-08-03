// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/user_notifier.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/agency/index.dart';
import 'package:wr_app/ui/column/pages/index.dart';
import 'package:wr_app/ui/extensions.dart';
import 'package:wr_app/ui/lesson/pages/index.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_search_iconbutton.dart';
import 'package:wr_app/ui/mypage/pages/index.dart';
import 'package:wr_app/ui/on_boarding/pages/index.dart';
import 'package:wr_app/ui/settings/pages/index.dart';
import 'package:wr_app/ui/travel/index.dart';

/// root view
class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

/// [RootView] state
class _RootViewState extends State<RootView>
    with SingleTickerProviderStateMixin {
  /// tab index
  int _index;

  /// navbar controller
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();

    /// on first launch, show on-boarding page
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final loggedIn =
          Provider.of<UserNotifier>(context, listen: false).loggedIn;
      final firstLaunch =
          Provider.of<SystemNotifier>(context, listen: false).getFirstLaunch();

      print('first launch: $firstLaunch, logged in: $loggedIn');

      // show on boarding modal
      if (firstLaunch || !loggedIn) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OnBoardingPage(),
            fullscreenDialog: true,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UserNotifier>(context);
    final user = notifier.getUser();
    final primaryColor = Theme.of(context).primaryColor;

    if (!notifier.loggedIn) {
      return const Scaffold();
    }

    final header = Row(
      children: <Widget>[
        Image.asset(
          'assets/icon/wr_coin.png',
          width: 30,
          height: 30,
        ).p_1(),
        Text(
          I.of(context).points(user.point),
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
          icon: const Icon(Icons.library_books),
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
        // physics: const NeverScrollableScrollPhysics(),
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
