import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/presentation/mypage/pages/input_introducer.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('友達紹介'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                child: Text(
                  '友達紹介',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                child: Text(
                  '友達に紹介すると1度だけ10000 WRCoinがケットできる',
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                child: Text(
                  '注意事項',
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '※紹介相手が有料版を購入している場合のみに、WRCoinが付与されます。',
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepOrangeAccent,
          isExtended: true,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => InputIntroducerPage()));
          },
          label: Text('友だちの紹介でアップグレードする'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
