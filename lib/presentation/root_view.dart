// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/index.dart';
import 'package:wr_app/presentation/lesson/widgets/phrase_search_iconbutton.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

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

  /// Check user status
  void _checkUserStatus(Duration timestamp) {
    // TODO: membership check
    // on first launch, show on-boarding page
    final loggedIn = Provider.of<UserNotifier>(context, listen: false).loggedIn;
    final firstLaunch =
        Provider.of<SystemNotifier>(context, listen: false).getFirstLaunch();

    InAppLogger.debug('first launch: $firstLaunch, logged in: $loggedIn');

    // show on boarding modal
    if (firstLaunch || !loggedIn) {
      Navigator.of(context).push(
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
    final notifier = Provider.of<UserNotifier>(context);
    final primaryColor = Theme.of(context).primaryColor;

    if (!notifier.loggedIn) {
      return const Scaffold();
    }

    final user = notifier.getUser();

    final header = Row(
      children: <Widget>[
        Image.asset(
          'assets/icon/wr_coin.png',
          width: 30,
          height: 30,
        ).p_1(),
        Text(
          I.of(context).points(user.statistics.points),
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
      ),
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
          icon: const Icon(Icons.bookmark_border),
          title: Text(I.of(context).bottomNavNote),
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

    final pageView = PageView(
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
        NotePage(),
        AgencyIndexPage(),
        MyPagePage(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: header,
        actions: actions,
      ),
      body: pageView,
      bottomNavigationBar: navbar,
    );
  }
}
