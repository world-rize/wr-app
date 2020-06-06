// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/model/example.dart';
import 'package:wr_app/model/message.dart';
import 'package:wr_app/ui/lesson/widgets/boldable_text.dart';

/// フレーズ例
class PhraseSampleView extends StatelessWidget {
  const PhraseSampleView({
    @required this.example,
    this.onMessageTapped,
    this.showTranslation = true,
    this.showKeyphrase = true,
  });

  final Example example;
  final Function(Message, int) onMessageTapped;
  final bool showTranslation;
  final bool showKeyphrase;

  Widget _createMessageView(
    Message message,
    int index, {
    bool primary = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            primary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // 英語メッセージ
          GestureDetector(
            onTap: () {
              if (onMessageTapped != null) {
                onMessageTapped(message, index);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 350,
              decoration: BoxDecoration(
                color:
                    primary ? Colors.lightBlue.shade300 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BoldableText(
                  text: message.text['en'],
                  basicStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: primary ? Colors.white : Colors.black,
                  ),
                  hide: !showKeyphrase,
                ),
              ),
            ),
          ),
          // アバター・日本語訳
          Container(
            // transform: Matrix4.translationValues(0, -10, 0),
            child: Row(
              textDirection: primary ? TextDirection.rtl : TextDirection.ltr,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    primary ? 'assets/icon/woman.png' : 'assets/icon/man.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    // child: Text(conversation.japanese),
                    child: showTranslation
                        ? BoldableText(
                            text: message.text['ja'],
                            basicStyle: const TextStyle(
                              fontSize: 12,
                            ),
                          )
                        : const Text(''),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: example.value
          .asMap()
          .map((i, message) =>
              MapEntry(i, _createMessageView(message, i, primary: i % 2 == 1)))
          .values
          .toList(),
    );
  }
}
