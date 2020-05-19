// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/agency/index.dart';
import 'package:wr_app/ui/column/index.dart';
import 'package:wr_app/ui/lesson/index.dart';
import 'package:wr_app/ui/mypage/index.dart';
import 'package:wr_app/ui/mypage/onboading_page.dart';
import 'package:wr_app/ui/travel/index.dart';
import 'package:wr_app/ui/mypage/settings_page.dart';
import 'package:wr_app/i10n/i10n.dart';

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
  int _index = 0;
  bool _isSearching = false;
  SearchBarController _searchBarController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    // init controller
    _pageController = PageController();
    _searchBarController = SearchBarController();

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

  // TODO(wakame-tech): 検索バーを実装
  Widget _createSearchBar() {
    return Container(
      height: 80,
      child: SearchBar<String>(
        searchBarController: _searchBarController,
        onSearch: (q) => Future.value(<String>['aaa', 'bbb', 'ccc']),
        onItemFound: (item, i) => Text(item),
      ),
    );
  }

  /// WIP
  void _stopSearch() {
    print('stop search');
    setState(() {
      _isSearching = false;
    });
  }

  /// WIP
  void _startSearch() {
    print('start search');
    setState(() {
      _isSearching = true;
    });
  }

  /// メイン画面
  Widget _tabView() {
    final userStore = Provider.of<UserStore>(context);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/icon/wr_coin.jpg',
                width: 32,
                height: 32,
              ),
            ),
            Text(
              I.of(context).points(userStore.user.point),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: <Widget>[
          // TODO(someone): 検索実装
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
//          IconButton(
//            icon: Icon(Icons.settings),
//            onPressed: () {
//              Navigator.of(context)
//                  .push(MaterialPageRoute(builder: (_) => SettingsPage()));
//            },
//          )
        ],
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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.create),
            title: Text(I.of(context).bottomNavLesson),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            title: Text(I.of(context).bottomNavColumn),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            title: Text(I.of(context).bottomNavTravel),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: Text(I.of(context).bottomNavAgency),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text(I.of(context).bottomNavMyPage),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _tabView();
  }
}
