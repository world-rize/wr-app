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

    // login
    // TODO(someone): ログイン画面を表示
    UserStore().signIn(email: 'a@b.com', password: '123456');
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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(I.of(context).points(userStore.user.point)),
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
        fixedColor: Colors.blueAccent,
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
