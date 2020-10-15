// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/ui/widgets/primary_button.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// リクエスト画面
const hintText = '''
(記入例)
「電気をつけっぱなしにしないで」はどうやって表現すれば良いですか？

”I’ll keep you company”はどのようなシチュエーションで使えば良いですか？

”I don’t understand”の言い換えってありますか？
''';
const infoText = '''⚠️リクエストに返答することはできません。
                可能な限りリクエストを反映させるのでNew coming Phraseを確認してください。''';

class RequestPageModel extends ChangeNotifier {
  RequestPageModel() : _text = '';

  String _text;
  set text(String value) {
    _text = value;
    notifyListeners();
  }

  String get text => _text;

  Widget submitButton(BuildContext context) {
    final ln = context.read<LessonNotifier>();
    return PrimaryButton(
      label: Text(I.of(context).sendRequestButton),
      onPressed: _text == '' ? null : () => ln.sendPhraseRequest(text: _text),
    );
  }
}

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RequestPageModel(),
      child: _RequestPage(),
    );
  }
}

class _RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<RequestPageModel>();
    final primaryColor = Theme.of(context).primaryColor;
    final backgroundColor = Theme.of(context).backgroundColor;

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
                          state.text = text;
                        },
                      ),
                    ),
                  ),
                ),
                const Text(infoText),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: state.submitButton(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
