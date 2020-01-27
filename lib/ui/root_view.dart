import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// pages
import 'package:wr_app/ui/lesson/lesson_page.dart';
import 'package:wr_app/ui/column/column_page.dart';
import 'package:wr_app/ui/travel/travel_page.dart';
import 'package:wr_app/ui/agency/agency_page.dart';
import 'package:wr_app/ui/mypage/mypage_page.dart';


class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _pages = <Widget>[
      LessonPage(),
      ColumnPage(),
      TravelPage(),
      AgencyPage(),
      MyPagePage(),
    ];

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('ここに検索バー'),
        ),
        child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('レッスン')),
                BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('コラム')),
                BottomNavigationBarItem(icon: Icon(Icons.schedule), title: Text('旅行')),
                BottomNavigationBarItem(icon: Icon(Icons.email), title: Text('留学先紹介')),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('マイページ')),
              ],
            ),
            tabBuilder: (context, index) => SafeArea(child: CupertinoTabView(
              builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 60.0),
                child: _pages.elementAt(index),
              ),
            ))
        )
    );
  }
}
