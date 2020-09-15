// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/index.dart';
import 'package:wr_app/presentation/lesson/pages/anything_search_page.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

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

  /// 自動でサインイン
  Future<void> _autoSignIn(BuildContext context) async {
    try {
      final an = context.read<AuthNotifier>();
      final un = context.read<UserNotifier>();
      final isAlreadySignIn = await an.isAlreadySignedIn();

      if (isAlreadySignIn) {
        await un.fetchUser();
        await an.login();

        Navigator.popUntil(context, (route) => route.isFirst);
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootView(),
          ),
        );
      }
    } on Exception catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  /// Check user status
  Future<void> _checkUserStatus(Duration timestamp) async {
    // TODO: membership check

    // on first launch, show on-boarding page
    final signedIn = await context.read<AuthNotifier>().isAlreadySignedIn();
    final loggedIn = context.read<UserNotifier>().signedIn;
    final firstLaunch = context.read<SystemNotifier>().getFirstLaunch();

    InAppLogger.debug('first launch: $firstLaunch');
    InAppLogger.debug('signed in: $signedIn');
    InAppLogger.debug('logged in: $loggedIn');

    if (signedIn && !loggedIn) {
      await _autoSignIn(context);
    }

    // show on boarding modal
    if (firstLaunch || !signedIn) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),
          fullscreenDialog: true,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback(_checkUserStatus);
  }

  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    final un = context.watch<UserNotifier>();
    final primaryColor = Theme.of(context).primaryColor;
    final user = un.user;

    final header = Row(
      children: <Widget>[
        // points
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/icon/wr_coin.png',
            width: 30,
            height: 30,
          ).padding(),
        ),
        Text(
          I.of(context).points(user.statistics.points),
          style: const TextStyle(color: Colors.white),
        ),
        // test limit
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.favorite, color: Colors.pinkAccent),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('${user.statistics.testLimitCount}',
              style: Theme.of(context).textTheme.caption),
        ),
        const Spacer(),
        if (_index == 0)
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AnythingSearchPage(),
                ),
              );
            },
          ),
        // settings
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SettingsPage(),
              fullscreenDialog: true,
            ));
          },
        ),
      ],
    );

    final navBar = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedItemColor: Theme.of(context).accentIconTheme.color,
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
            icon: const Icon(Icons.bookmark_border),
            title: Text(I.of(context).bottomNavNote),
          ),
//        BottomNavigationBarItem(
//          icon: const Icon(Icons.public),
//          title: Text(I.of(context).bottomNavAgency),
//        ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            title: Text(I.of(context).bottomNavMyPage),
          ),
        ],
      ),
    );

    final pageView = PageView(
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
        NotePage(),
        // AgencyIndexPage(),
        MyPagePage(),
      ],
    );

    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.all(10),
          child: header,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: env.useEmulator ? Colors.redAccent : primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 20,
                  spreadRadius: 1,
                )
              ]),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 150),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: pageView,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: navBar,
          ),
        ],
      ),
    );
  }
}
