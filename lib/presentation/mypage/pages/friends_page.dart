// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/presentation/on_boarding/widgets/loading_view.dart';

/// mypage > index > FriendsPage
class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String _userId;
  bool _isLoading;

  Future _showUserNotFoundDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('ユーザーが見つかりませんでした'),
          actions: <Widget>[
            FlatButton(
              child: const Text('ok'),
              key: const Key('ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _showConfirmDialog(User introducee) async {
    var confirm = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('${introducee.name} さんを紹介者として登録しますか？'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              key: const Key('ok'),
              onPressed: () async {
                Navigator.pop(context);
                confirm = true;
              },
            ),
            FlatButton(
              child: const Text('No'),
              key: const Key('no'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return confirm;
  }

  Future _showSuccessDialog(User introducee) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Text('${introducee.name} さんに10000ポイントが送られました\n自分は500ポイントゲットしました'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              key: const Key('Ok'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future _showErrorDialog(dynamic e) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              key: const Key('Ok'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future _searchUserId(String userId) async {
    final un = Provider.of<UserNotifier>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final introducee = await un.searchUserFromUserId(userId: userId);
    setState(() {
      _isLoading = false;
    });
    if (introducee == null) {
      await _showUserNotFoundDialog();
      return;
    }

    final confirm = await _showConfirmDialog(introducee);
    if (!confirm) {
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      await un.introduceFriend(introduceeId: introducee.userId);
      await _showSuccessDialog(introducee);
    } on Exception catch (e) {
      await _showErrorDialog(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userId = '';
    _isLoading = false;
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
      body: LoadingView(
        loading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '友人に紹介すると１度だけWRCoinがゲットできる！',
                style: h5,
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('紹介相手が有料版を購入している場合のみWRCoinが付与されます。'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    child: const Text('検索'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
