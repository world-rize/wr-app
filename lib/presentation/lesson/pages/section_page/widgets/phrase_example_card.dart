// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/presentation/voice_player.dart';
import 'package:wr_app/ui/widgets/boldable_text.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// phrase example view
class PhraseExampleCard extends StatelessWidget {
  const PhraseExampleCard({
    @required this.phrase,
  });

  final Phrase phrase;

  Widget _createMessageView({
    BuildContext context,
    Function onPressed,
    Message message,
    int index,
    bool primary = false,
  }) {
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
            onTap: onPressed,
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
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: primary ? Colors.white : Colors.black,
                  ),
                  hide: false,
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

  Widget _noteOptions(BuildContext context, Note note, Phrase phrase) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        print('tapped');
        Navigator.of(context).pop();
        await Provider.of<NoteNotifier>(
          context,
          listen: false,
        ).addLessonPhraseToNote(note.id, phrase).then((value) {
          print('ok');
        }).catchError(
          (_) {
            // TODO: ちゃんとエラー用のshowToastをエラー表示用のwidget作る
            Fluttertoast.showToast(
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.deepOrangeAccent,
              msg: 'Space has been used up.',
            );
          },
        );
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.all(8),
        child: Center(child: Text(note.title)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vp = Provider.of<VoicePlayer>(context);
    final ln = Provider.of<LessonNotifier>(context);
    final un = Provider.of<UserNotifier>(context);

    final showTranslation = ln.getShowTranslation();

    // TODO: phrase.id !== notePhrase.uuid
    final existNotes = un.existPhraseInNotes(phraseId: phrase.id);
    final favorited = un.existPhraseInFavoriteList(phraseId: phrase.id);

    final _addNotesButton = IconButton(
      icon: Icon(
        un.existPhraseInNotes(phraseId: phrase.id)
            ? Icons.bookmark
            : Icons.bookmark_border,
        color: Colors.grey,
      ),
      onPressed: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context, _) => Material(
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 30,
                    padding: EdgeInsets.all(8),
                    child: Center(child: Text('Add Phrase to Note')),
                  ),
                  Divider(),
                  ...un.user.notes.entries
                      // TODO: ここwhereするの汚い
                      .where((element) => !element.value.isAchievedNote)
                      .map((e) => _noteOptions(context, e.value, phrase))
                      .toList(),
                ],
              ),
            ),
          ),
        );
        // un.addPhraseInNote(
        //     // TODO: ノートを選べるようにする
        //     // noteId: 'default', phrase: NotePhrase.fromPhrase(phrase));
      },
    );

    final _favoriteButton = IconButton(
        icon: Icon(
          favorited ? Icons.favorite : Icons.favorite_border,
          color: Colors.redAccent,
        ),
        onPressed: () {
          un.favoritePhrase(phraseId: phrase.id, favorite: !favorited);
        });

    final _buttons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _addNotesButton,
        _favoriteButton,
      ],
    );

    final header = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    phrase.title['ja'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.accentColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buttons,
              ),
            ],
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
          (i, message) => _createMessageView(
            context: context,
            onPressed: () => vp.playMessages(messages: [message]),
            message: message,
            index: i,
            primary: i.isOdd,
          ),
        ),
      ]),
    );
  }
}
