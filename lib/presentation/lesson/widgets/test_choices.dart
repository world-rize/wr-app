// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_example_card.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

// TODO(someone): 遷移アニメーション
/// 問題画面
///
/// [phrase] と [selection] を表示し選択されたら [onNext] がコールバックされる
class TestChoices extends StatefulWidget {
  const TestChoices({
    required this.index,
    required this.phrase,
    required this.selection,
    required this.onNext,
  });

  /// index
  final int index;

  /// フレーズ
  final Phrase phrase;

  /// 選択肢
  final List<String> selection;

  /// コールバック
  final void Function(int) onNext;

  @override
  _TestChoicesState createState() => _TestChoicesState();
}

class _TestChoicesState extends State<TestChoices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 5,
          child: SingleChildScrollView(
            child: PhraseExampleCard(
              phrase: widget.phrase,
              isTest: true,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: _createSelection(),
        ),
      ],
    );
  }

  /// 選択肢
  Widget _createSelection() {
    final theme = Theme.of(context);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            widget.onNext(index);
          },
          child: ShadowedContainer(
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                widget.selection[index],
                style: theme.textTheme.bodyText1.apply(color: Colors.white),
              ),
            ),
          ),
        ).padding(6);
      },
      itemCount: 4,
    );
  }
}
