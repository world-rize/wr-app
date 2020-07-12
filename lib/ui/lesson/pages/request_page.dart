// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// リクエスト画面
class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String _text;

  @override
  void initState() {
    super.initState();
    _text = '';
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<LessonNotifier>(context);
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
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'リクエストを送る',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ShadowedContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      maxLines: 20,
                      decoration:
                          const InputDecoration.collapsed(hintText: hintText),
                      onSubmitted: (text) {
                        setState(() {
                          _text = text;
                        });
                      },
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
          onPressed: () async {
            await notifier.sendPhraseRequest(text: _text);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
