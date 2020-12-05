// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/usecase/lesson_service.dart';

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
    final lessonService = GetIt.I<LessonService>();
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).backgroundColor;
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                    color: backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        maxLines: 20,
                        decoration:
                            const InputDecoration.collapsed(hintText: hintText),
                        onChanged: (text) {
                          setState(() {
                            _text = text;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const Text(
                    '⚠️リクエストに返信することはできません。\n可能な限りリクエストを反映させるのでNew coming Phraseを確認してください。'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: PrimaryButton(
          label: Text(I.of(context).sendRequestButton),
          onPressed: _text == ''
              ? null
              : () async {
                  await lessonService.sendPhraseRequest(text: _text);
                },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
