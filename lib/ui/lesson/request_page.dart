// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// リクエスト画面
class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  // String _requestType;
  String _message;

  // リクエストの種類
//  static final List<String> requestTypes = [
//    '新しいフレーズがほしい',
//    'アプリの感想',
//    'その他要望',
//  ];

  @override
  void initState() {
    super.initState();
    // _requestType = requestTypes[0];
    _message = '';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const hintText = '''
(記入例)
「電気をつけっぱなしにしないで」はどうやって表現すれば良いですか？

”I’ll keep you company”はどのようなシチュエーションで使えば良いですか？

”I don’t understand”の言い換えってありますか？
    ''';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(I.of(context).requestPhrase),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'リクエストを送る',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ShadowedContainer(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: TextField(
                      maxLines: 20,
                      decoration: InputDecoration.collapsed(hintText: hintText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: PrimaryButton(
          label: const Text('送信'),
          onPressed: () {
            // TODO(someone): send email
            print('$_message');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
