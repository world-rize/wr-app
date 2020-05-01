// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/store/env.dart';
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
    UserStore().signIn();
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
    final envStore = Provider.of<EnvStore>(context);
    final userStore = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('${userStore.user.point} ポイント'),
            Text(I.of(context).hello),
          ],
        ),
        actions: <Widget>[
          // TODO(someone): 検索実装
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
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
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            title: const Text('レッスン'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            title: const Text('コラム'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            title: const Text('旅行'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            title: const Text('留学先紹介'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: const Text('マイページ'),
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
