import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// search bar
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.all(
//                const Radius.circular(10.0),
//              ),
//            ),
        hintText: "Phrase",
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WR App',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
      home: PageContainer(),
    );
  }
}

// root widget
class PageContainer extends StatefulWidget {
  PageContainer({ Key key }) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  // selected view's index
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // page views
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'レッスン',
      style: optionStyle,
    ),
    Text(
      'コラム',
      style: optionStyle,
    ),
    Text(
      '旅行',
      style: optionStyle,
    ),
    Text(
      '留学先紹介',
      style: optionStyle,
    ),
    Text(
      'マイページ',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("AAA"),
        title: SearchBar(),
        // Text('Bottom Navigation Bar Demo'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search),
//          )
//        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // some contents
            _widgetOptions.elementAt(_selectedIndex),
            // slide view
            Row(
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    // width: 200.0,
                    height: 300.0,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                            "http://via.placeholder.com/200x300",
                            fit: BoxFit.contain,
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
      ),
    );
  }
}
