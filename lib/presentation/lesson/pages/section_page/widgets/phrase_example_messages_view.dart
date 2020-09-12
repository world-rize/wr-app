// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/presentation/lesson/notifier/voice_player.dart';
import 'package:wr_app/ui/widgets/boldable_text.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// phrase example view
class PhraseExampleCard extends StatelessWidget {
  const PhraseExampleCard({
    @required this.phrase,
  });

  final Phrase phrase;

  Widget _createMessageView(
    BuildContext context,
    Message message,
    int index, {
    bool primary = false,
  }) {
    // TODO
    final showKeyphrase = false;
    final showTranslation = false;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            primary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // 英語メッセージ
          GestureDetector(
            onTap: () {
              context.watch<VoicePlayer>().playMessages(messages: [message]);
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
    final theme = Theme.of(context);
    final voicePlayer = Provider.of<VoicePlayer>(context);
    final lessonNotifier = Provider.of<LessonNotifier>(context);
    final showTranslation = lessonNotifier.getShowTranslation();

    final header = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: Text(
              phrase.title['en'],
              style: TextStyle(
                fontSize: 20,
                color: theme.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              phrase.title['ja'],
              style: TextStyle(
                fontSize: 16,
                color: theme.accentColor,
              ),
            ),
          ),
        ],
      ),
    );

    return ShadowedContainer(
      color: theme.backgroundColor,
      child: Column(children: [
        // header
        header,

        // messages
        ...phrase.example.value.indexedMap(
          (i, message) =>
              _createMessageView(context, message, i, primary: i.isOdd),
        ),
      ]),
    );
  }
}
