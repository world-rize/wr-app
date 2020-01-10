import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// pages
import 'package:wr_app/ui/lesson/lesson_page.dart';
import 'package:wr_app/ui/column/column_page.dart';
import 'package:wr_app/ui/travel/travel_page.dart';
import 'package:wr_app/ui/agency/agency_page.dart';
import 'package:wr_app/ui/mypage/mypage_page.dart';

// components
import 'package:wr_app/ui/search_bar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: RootView(),
    );
  }
}

// root widget
class RootView extends StatefulWidget {
  RootView({Key key}) : super(key: key);

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  // selected view's index
  // int _selectedIndex = 0;

  // page views
  List<Widget> _pages;

//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//    });
//  }

  // ページ
  List<Widget> _createPages() {
    return <Widget>[
      LessonPage(),
      ColumnPage(),
      TravelPage(),
      AgencyPage(),
      MyPagePage(),
    ];
  }

  // 下部ナビゲーションバー
  CupertinoTabBar _createNavBar() {
    return CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('レッスン'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('コラム'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          title: Text('旅行'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.email),
          title: Text('留学先紹介'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('マイページ'),
        ),
      ],
//      currentIndex: _selectedIndex,
//      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = _createPages();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Hoge"),
      ),
      child: SafeArea(
        child: CupertinoTabScaffold(
            tabBar: _createNavBar(),
            tabBuilder: (context, index) {
              return CupertinoTabView(builder: (context) {
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 60.0),
                  child: _pages.elementAt(index)
                );
              });
            }),
      ),
    );
  }
}
