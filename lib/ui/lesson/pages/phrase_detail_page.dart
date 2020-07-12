// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_advice.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_buttons.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_detail_sample.dart';
import 'package:wr_app/ui/lesson/widgets/voice_player.dart';
import 'package:wr_app/ui/widgets/toast.dart';

/// Lesson > index >
/// - phrase detail page
class PhrasesDetailPage extends StatelessWidget {
  const PhrasesDetailPage({@required this.phrase});

  final Phrase phrase;

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<PreferenceNotifier>(context);

    return ChangeNotifierProvider<VoicePlayer>(
      create: (_) => VoicePlayer(
        phrase: phrase,
        onError: NotifyToast.error,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PhraseDetailSample(
              showTranslation: prefs.showTranslation,
            ),
            PhraseDetailAdvice(),
            PhraseDetailButtons(),
          ],
        ),
      ),
    );
  }
}
