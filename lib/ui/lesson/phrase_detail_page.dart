// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/model/phrase/phrase.dart';
import 'package:wr_app/ui/common/toast.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_advice.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_buttons.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_sample.dart';
import 'package:wr_app/ui/lesson/widgets/voice_player.dart';

/// フレーズ詳細ページ
///
/// ## プロトタイプ
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134>
class PhrasesDetailPage extends StatelessWidget {
  const PhrasesDetailPage({@required this.phrase});

  // TODO: 日本語 <=> 英語 切り替え

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VoicePlayer>(
      create: (_) => VoicePlayer(
        phrase: phrase,
        onError: NotifyToast.error,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PhraseDetailSample(),
            PhraseDetailAdvice(),
            PhraseDetailButtons(),
          ],
        ),
      ),
    );
  }
}
