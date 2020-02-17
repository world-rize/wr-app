// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:wr_app/ui/agency/index.dart';
import 'package:wr_app/ui/column/index.dart';
import 'package:wr_app/ui/lesson/index.dart';
import 'package:wr_app/ui/mypage/index.dart';
import 'package:wr_app/ui/travel/index.dart';
import 'package:wr_app/env.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  bool _isSearching = false;
  SearchBarController _searchBarController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _searchBarController = SearchBarController();
  }

  // TODO(wakame-tech): implement
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

  void _stopSearch() {
    print('stop search');
    setState(() {
      _isSearching = false;
    });
  }

  void _startSearch() {
    print('start search');
    setState(() {
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${Env.APP_NAME} ${Env.VERSION}'),
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
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
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
            ]));
  }
}
