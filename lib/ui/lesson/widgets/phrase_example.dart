// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';

import 'package:wr_app/model/message.dart';
import 'package:wr_app/model/example.dart';

/// フレーズ例
class PhraseSampleView extends StatelessWidget {
  const PhraseSampleView({@required this.example});
  final Example example;

  /// "()" で囲まれた部分を太字にします
  /// 例 "abc(def)g" -> "abc<strong>def</strong>g"
  Text _boldify(String text, TextStyle basicStyle) {
    final _children = <InlineSpan>[];
    // not good code
    text.splitMapJoin(RegExp(r'\((.*)\)'), onMatch: (match) {
      _children.add(TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold).merge(basicStyle),
      ));
      return '';
    }, onNonMatch: (plain) {
      _children.add(TextSpan(
        text: plain,
        style: basicStyle,
      ));
      return '';
    });

    return Text.rich(
      TextSpan(children: _children),
      softWrap: true,
    );
  }

  Widget _createMessageView(Message message, {bool primary = false}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            primary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // 英語メッセージ
          Container(
            padding: const EdgeInsets.all(10),
            width: 350,
            decoration: BoxDecoration(
              color: primary ? Colors.lightBlue : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _boldify(
                message.text['en'],
                TextStyle(
                  fontSize: 22,
                  color: Colors.white,
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
                  child: Image.network(
                    'https://placehold.jp/150x150.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    // child: Text(conversation.japanese),
                    child: _boldify(
                      message.text['ja'],
                      const TextStyle(),
                    ),
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
              MapEntry(i, _createMessageView(message, primary: i % 2 == 1)))
          .values
          .toList(),
    );
  }
}
