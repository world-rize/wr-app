// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/phrase.dart';
import 'package:wr_app/presentation/lesson/pages/section_page/widgets/phrase_example_card.dart';
import 'package:wr_app/ui/theme.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/util/extensions.dart';

// TODO(someone): 遷移アニメーション
/// 問題画面
///
/// [phrase] と [choices] を表示し選択されたら [onNext] がコールバックされる
/// [answerIndex] と一致していたら緑 不正解で赤
///
class TestChoices extends StatefulWidget {
  const TestChoices({
    @required this.phrase,
    @required this.choices,
    @required this.answerIndex,
    @required this.onNext,
  });

  /// フレーズ
  final Phrase phrase;

  /// 選択肢
  final List<String> choices;

  /// 正解のindex
  final int answerIndex;

  /// コールバック
  final void Function(int) onNext;

  @override
  State<TestChoices> createState() => TestChoicesState();
}

class TestChoicesState extends State<TestChoices> {
  /// 選択しているindex
  int choiceIndex;

  /// 選択後はロック
  bool _isLock;

  @override
  void initState() {
    super.initState();
    choiceIndex = -1;
    _isLock = false;
  }

  /// 選択に応じて選択肢の色を変える
  Color _rowBgColor(int index) {
    if (index == choiceIndex) {
      if (choiceIndex == widget.answerIndex) {
        return Palette.correctColor;
      } else {
        return Palette.inCorrectColor;
      }
    } else {
      return Colors.lightBlueAccent;
    }
  }

  Future _onTap(int index) async {
    if (_isLock) {
      return;
    }

    // :thinking_face:
    setState(() {
      choiceIndex = index;
      _isLock = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      choiceIndex = -1;
      _isLock = false;
    });

    widget.onNext(index);
  }

  /// 選択肢
  Widget _choiceRow(BuildContext context, int index) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyText2.apply(color: Colors.white);

    return InkWell(
      onTap: () => _onTap(index),
      child: ShadowedContainer(
        color: _rowBgColor(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            widget.choices[index],
            style: style,
          ),
        ),
      ),
    ).padding();
  }

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
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.choices.length,
            itemBuilder: _choiceRow,
          ),
        ),
      ],
    );
  }
}
