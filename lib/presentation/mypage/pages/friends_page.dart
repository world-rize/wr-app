// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';

/// mypage > index > FriendsPage
class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String _userId;

  Future _searchUserId(String userId) async {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final result = await userNotifier.searchUserFromUserId(userId: userId);

    if (result == null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('ゆーざーが見つかりませんでした'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                key: Key('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Found ${result.name} さん'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                key: Key('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _userId = '';
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);
    final h5 = Theme.of(context).textTheme.headline5;

    final _searchUserIdField = TextFormField(
      onChanged: (userId) {
        setState(() => _userId = userId);
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: 'ユーザーID',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('友人紹介'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '友人に紹介すると１度だけWRCoinがゲットできる！',
              style: h5,
            ),
            Text('紹介相手が有料版を購入している場合のみWRCoinが付与されます。'),
            Column(
              children: [
                Text(
                  'あなたのID',
                  style: h5,
                ),
                Text(
                  userNotifier.getUser().userId,
                  style: h5,
                ),
                Text(
                  '紹介者のIDを入力する',
                  style: h5,
                ),
                _searchUserIdField,
                RaisedButton(
                  onPressed: () => _searchUserId(_userId),
                  child: Text('検索'),
                ),
                Text('SNSでIDを共有する'),
                Text(
                  '11A22B',
                  style: h5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
