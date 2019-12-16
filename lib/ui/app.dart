import 'package:flutter/material.dart';

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
      title: 'WR App',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
      home: RootView(),
    );
  }
}

// root widget
class RootView extends StatefulWidget {
  RootView({ Key key }) : super(key: key);

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  // selected view's index
  int _selectedIndex = 0;

  // page views
  List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
  BottomNavigationBar _createNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
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
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey[400],
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = _createPages();

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(),
      ),
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _createNavBar(),
    );
  }
}
