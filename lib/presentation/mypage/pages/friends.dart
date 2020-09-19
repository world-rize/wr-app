import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text('hoge'),
              Text('hoge'),
              Text('hoge'),
              Text('hoge'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {},
          child: Text('hoge'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
