import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

class Section {
  bool isExpanded = false;
  String title;
  List<String> phrases;

  Section(this.title, this.phrases, {this.isExpanded: false});
}

class SectionSelectPage extends StatefulWidget {
  @override
  _SectionSelectPageState createState() => _SectionSelectPageState();
}

class _SectionSelectPageState extends State<SectionSelectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = [
    Tab(text: 'Lesson'),
    Tab(text: 'Test'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  Widget _createSectionView(Section section) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: GFListTile(
        // left
        avatar: Text(section.title, style: TextStyle(fontSize: 28)),
        // middle
        title: Text('クリア',
            style: TextStyle(color: Colors.redAccent, fontSize: 20)),
        // right
        icon: GFButton(
          onPressed: () {},
          child: Text('Start', style: TextStyle(fontSize: 25)),
          color: Colors.orange,
          borderShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  Widget _createTabView(Tab tab) {
    final _sections = List<Section>.generate(
        10, (i) => Section('Section $i', ['a', 'b', 'c', 'd']));

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _sections.map(_createSectionView).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('School'),
            bottom: TabBar(
              tabs: _tabs,
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              labelStyle: TextStyle(fontSize: 20),
            )),
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map(_createTabView).toList(),
        ));
  }
}
