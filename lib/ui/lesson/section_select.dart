import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// TODO hide root navbar

class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

class _SectionSelectPageState extends State<SectionSelectPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // on mounted
//    WidgetsBinding.instance.addPostFrameCallback((_) => showModalBottomSheet(
//      context: context,
//      builder: (context) {
//        return Container(
//          height: 400.0,
//          child: Padding(
//            padding: EdgeInsets.all(30.0),
//            child: Text("AAA"),
//          ),
//        );
//      },
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.all(Radius.circular(20.0)),
//      ),
//      isDismissible: false,
//    ));
  }

  Widget _createLessonTabView() {
    return Text("Lesson");
  }

  Widget _createTestTabView() {
    return Text("Test");
  }

  final _tabs = <Tab>[Tab(text: "Lesson"), Tab(text: "Test")];

  List<Widget> _createTabBarViews() {
    return [
      _createLessonTabView(),
      _createTestTabView(),
    ];
  }

  Widget _createUnderlinedTabbedCard() {
    var _tabBarViews = _createTabBarViews();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black87,
                indicatorWeight: 6.0,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.orange,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 2.0),
                tabs: _tabs,
              ),
            ),
            body: TabBarView(
              children: _tabBarViews,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black45,
        child: _createUnderlinedTabbedCard(),
      ),
    );
  }
}
