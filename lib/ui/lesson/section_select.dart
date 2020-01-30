import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

class Section {
  bool isExpanded = false;
  String title;
  List<String> phrases;

  Section(this.title, this.phrases, {this.isExpanded: false});
}

class SectionSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Colors.teal,
        title: Text('UI Kit'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GFListTile(
              titleText: 'Title',
              subtitleText:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing',
              icon: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}
