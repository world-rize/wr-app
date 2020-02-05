// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  PageController _pageController = PageController();

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
                  icon: Icon(Icons.home), title: Text('レッスン')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('コラム')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.schedule), title: Text('旅行')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email), title: Text('留学先紹介')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('マイページ')),
            ]));
  }
}

//    return CupertinoPageScaffold(
//        navigationBar: CupertinoNavigationBar(
//          middle: Text('ここに検索バー'),
//        ),
//        child: CupertinoTabScaffold(
//            tabBar: CupertinoTabBar(
//              items: [
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.home), title: Text('レッスン')),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.business), title: Text('コラム')),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.schedule), title: Text('旅行')),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.email), title: Text('留学先紹介')),
//                BottomNavigationBarItem(
//                    icon: Icon(Icons.person), title: Text('マイページ')),
//              ],
//            ),
//            tabBuilder: (context, index) => SafeArea(
//                    child: CupertinoTabView(
//                  builder: (context) => SingleChildScrollView(
//                    padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 60.0),
//                    child: _pages.elementAt(index),
//                  ),
//                ))));
