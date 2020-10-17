// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/system/model/app_info.dart';
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

        // Navigator.popUntil(context, (route) => route.isFirst);
        // return Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => RootView(),
        //   ),
        // );
      }
    } on Exception catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }

  bool _isAvailable(AppInfo info) {
    return (Platform.isIOS && info.isIOsAppAvailable) ||
        (Platform.isAndroid && info.isAndroidAppAvailable);
  }

  /// Check app status
  Future _checkAppStatus() async {
    InAppLogger.debug('AppInfo');
    final sn = Provider.of<SystemNotifier>(context);
    final appInfo = await sn.getAppInfo();
    InAppLogger.debugJson(appInfo.toJson());

    if (!_isAvailable(appInfo)) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),
          fullscreenDialog: true,
        ),
      );
    }
  }

  /// Check user status
  Future<void> _checkUserStatus() async {
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

  /// page loaded callback
  void onPageLoaded() {
    _checkAppStatus();
    _checkUserStatus();
  }

  @override
  void initState() {
    super.initState();
    _index = 0;
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) => onPageLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    final un = context.watch<UserNotifier>();
    final primaryColor = Theme.of(context).primaryColor;
    final user = un.user;
    assert(user != null);

    final coins = Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Image.asset(
            'assets/icon/wr_coin.png',
            width: 20,
            height: 20,
          ).padding(),
          Text(
            '${user.statistics.points}',
            style: Theme.of(context).primaryTextTheme.headline6,
          ).padding(),
        ],
      ),
    );

    final limits = Row(children: [
      ...List.generate(3, (index) => index < user.statistics.testLimitCount)
          .map((b) => Icon(b ? Icons.favorite : Icons.favorite_border,
              color: Colors.pinkAccent)),
    ]).padding();

    final searchButton = IconButton(
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
    );

    final settingsButton = IconButton(
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
    );

    final header = Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          // points
          coins,
          // test limit
          limits,
          const Spacer(),
          if (_index == 0) searchButton,
          // settings
          settingsButton,
        ],
      ),
    );

    final navBar = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        backgroundColor: primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.create),
            title: Text(I.of(context).bottomNavLesson),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_border),
            title: Text(I.of(context).bottomNavNote),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.view_column),
            title: Text(I.of(context).bottomNavColumn),
          ),
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
        NotePage(),
        ColumnIndexPage(),
        // AgencyIndexPage(),
        MyPagePage(),
      ],
    );

    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          //padding: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
