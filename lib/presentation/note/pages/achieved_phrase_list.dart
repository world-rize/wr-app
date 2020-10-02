// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';

/// mypage > index > Achieved List
///
/// - ノートにつけられた Achieved の一覧
class AchievedPhraseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final achievedNote = un.user.getAchievedNote();

    final englishStyle = Theme.of(context).primaryTextTheme.bodyText1;
    final japaneseStyle = Theme.of(context).primaryTextTheme.bodyText2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...achievedNote.phrases
            .map(
              (phrase) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShadowedContainer(
                  color: Theme.of(context).backgroundColor,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    phrase.english,
                                    style: englishStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    phrase.japanese,
                                    style: japaneseStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
