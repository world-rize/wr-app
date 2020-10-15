// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/model/message.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/presentation/lesson/pages/phrase_page_view/index.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/boldable_text.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

/// phrase example view testなら[isTest]trueでキーフレーズを隠す
class PhraseExampleCard extends StatelessWidget {
  const PhraseExampleCard({
    @required this.phrase,
    @required this.isTest,
  });

  final Phrase phrase;
  final bool isTest;

  Widget _createMessageView({
    BuildContext context,
    Function onPressed,
    Message message,
    int index,
    bool primary = false,
  }) {
    final ln = Provider.of<LessonNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            primary ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // TODO: if (primary) で分けるべき
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
                // TODO: ViewModelはNotifierに書くべき
                child: BoldableText(
                  text: isTest
                      ? message.text['en']
                      : (ln.showEnglish
                          ? message.text['en']
                          : ' ' * message.text['en'].length),
                  basicStyle: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2
                      .apply(color: primary ? Colors.white : Colors.black),
                  hide: isTest,
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
                      child: BoldableText(
                        text: isTest
                            ? message.text['ja']
                            : (ln.showJapanese
                                ? message.text['ja']
                                // TODO: 文字の端が等幅フォントじゃないのでなにか考える
                                : '　' * message.text['ja'].length),
                        basicStyle:
                            Theme.of(context).primaryTextTheme.bodyText2,
                      )),
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
        // ちゃんとノートを選択したらtrueを返す
        Navigator.of(context).pop(true);
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
    final un = Provider.of<UserNotifier>(context);

    // TODO: phrase.id !== notePhrase.uuid
    final favorited = un.existPhraseInFavoriteList(phraseId: phrase.id);

    final _addNotesButton = LikeButton(
      isLiked: false,
      circleColor: CircleColor(
        start: Colors.lightBlue[100],
        end: Colors.lightBlue[400],
      ),
      bubblesColor: BubblesColor(
        dotSecondaryColor: Colors.lightBlue[100],
        dotPrimaryColor: Colors.lightBlue[400],
      ),
      likeBuilder: (_) => Icon(
        // TODO: ここどうするのか
        // ノートはフレーズを編集できてしまうので存在するもクソもない?
        un.user.existPhraseInNotes(phraseId: phrase.id)
            ? Icons.bookmark
            : Icons.bookmark_border,
        color: Colors.grey,
      ),
      onTap: (_) async {
        return showCupertinoModalBottomSheet(
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
        ).then((value) {
          if (value == null) {
            print('value is null');
            return false;
          }
          return value;
        });
        // un.addPhraseInNote(
        //     // TODO: ノートを選べるようにする
        //     // noteId: 'default', phrase: NotePhrase.fromPhrase(phrase));
      },
    );

    final _favoriteButton = LikeButton(
      isLiked: favorited,
      circleColor: CircleColor(
        start: Colors.redAccent[100],
        end: Colors.redAccent[400],
      ),
      bubblesColor: BubblesColor(
        dotSecondaryColor: Colors.redAccent[100],
        dotPrimaryColor: Colors.redAccent[400],
      ),
      likeBuilder: (isLiked) => Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: Colors.redAccent,
      ),
      onTap: (isLiked) async {
        un.favoritePhrase(
          phraseId: phrase.id,
          favorite: !isLiked,
        );
        return !isLiked;
      },
    );

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
            onPressed: isTest
                ? null
                : () => Provider.of<VoicePlayer>(context, listen: false)
                    .playMessages(messages: [message]),
            message: message,
            index: i,
            primary: i.isOdd,
          ),
        ),
      ]),
    );
  }
}
