import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// TODO hide root navbar

class Section {
  bool isExpanded = false;
  String title;
  List<String> phrases;

  Section(this.title, this.phrases, {this.isExpanded: false});
}

class LessonListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LessonListViewState();
  }
}

// TODO ExpansionTile
ExpansionTile _createChildPanel(Section section) {
  return ExpansionTile(
    title: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
              child: Text(section.title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
              padding: EdgeInsets.only(right: 10.0),
            ),
            Padding(
              child: Text(
                "未クリア", style: TextStyle(fontSize: 18.0, color: Colors.red),),
              padding: EdgeInsets.only(right: 10.0),
            ),
            RaisedButton(
              child: Text("Start",
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              onPressed: () {},
            )
          ],
        ),
    ),
    children: <Widget>[
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text('$index');
          },
          itemCount: 10,
          // solution for solve assertion list-view <https://stackoverflow.com/questions/52023610/getting-horizontal-viewport-was-given-unbounded-height-with-tabbarview-in-flu>
          shrinkWrap: true,
        ),
      ],
  );
}

class LessonListViewState extends State<LessonListView> {
  var _sections = <Section>[];

  @override
  void initState() {
    _sections = [
      Section("Section1", ["1", "2", "3", "4"]),
      Section("Section2", ["1", "2", "3", "4"]),
      Section("Section3", ["1", "2", "3", "4"]),
      Section("Section4", ["1", "2", "3", "4"]),
      Section("Section5", ["1", "2", "3", "4"]),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child: ListView(
              children: <Widget>[
                ExpansionTile(
                  children: _sections.map(_createChildPanel).toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SectionSelectPage extends StatelessWidget {
  Widget _createLessonTabView() {
    return LessonListView();
  }

  Widget _createTestTabView() {
    return Text("Test");
  }

  final _tabs = <Tab>[Tab(text: "Lesson"), Tab(text: "Test")];

//  Widget _createUnderlinedTabbedCard() {
//    return Card(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(40.0),
//      ),
//      child: Padding(
//        padding: EdgeInsets.only(top: 30.0),
//        child: DefaultTabController(
//          length: 2,
//          child: Scaffold(
//            appBar: AppBar(
//              backgroundColor: Colors.white,
//              automaticallyImplyLeading: false,
//              elevation: 0,
//              title: TabBar(
//                unselectedLabelColor: Colors.grey,
//                labelColor: Colors.black87,
//                indicatorWeight: 6.0,
//                indicatorSize: TabBarIndicatorSize.label,
//                indicatorColor: Colors.orange,
//                indicatorPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                tabs: _tabs,
//              ),
//            ),
//            body: TabBarView(
//              children: [
//                _createLessonTabView(),
//                _createTestTabView(),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }

  Widget _createUnderlinedTabbedCard() {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            // タブのオプション
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            labelColor: Colors.yellowAccent,
            labelStyle: TextStyle(fontSize: 16.0),
            unselectedLabelStyle: TextStyle(fontSize: 12.0),
            indicatorWeight: 2.0,
            // タブに表示する内容
            tabs: [
              Tab(
                child: Text('Top'),
              ),
              Tab(
                child: Text('Business'),
              ),
              Tab(
                child: Text('Technology'),
              ),
              Tab(
                child: Text('Finance'),
              ),
              Tab(
                child: Text('Food'),
              ),
              Tab(
                child: Text('Economic'),
              ),
              Tab(
                child: Text('Game'),
              )
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          // 各タブの内容
          children: [
            Icon(Icons.directions_car),
            // new FirstTab('test'),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_car)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.black45,
      child: _createUnderlinedTabbedCard(),
    );
  }
}
