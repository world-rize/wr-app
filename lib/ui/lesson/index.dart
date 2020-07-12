// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/user/user_notifier.dart';
import 'package:wr_app/extension/collection_extension.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/ui/lesson/favorite_page.dart';
import 'package:wr_app/ui/lesson/request_page.dart';
import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/carousel_cell.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

/// `レッスン` ページのトップ
///
class LessonIndexPage extends StatelessWidget {
  Future<void> _sendAnalyticsEvent(BuildContext context) async {
    final userStore = Provider.of<UserNotifier>(context);
    if (userStore == null) {
      return;
    }
    final analytics = Provider.of<FirebaseAnalytics>(context);
    await analytics.logEvent(
      name: 'test_event',
      parameters: {
        'uid': userStore.user.uuid,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserNotifier>(context);
    final lessonNotifier = Provider.of<LessonNotifier>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const GFTypography(
            text: 'Lesson',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.PRIMARY,
          ),

          // TODO(someone): fix LessonSelectCarousel
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: GFCarousel(
              enableInfiniteScroll: false,
              items: lessonNotifier.lessons
                  .indexedMap(
                    (index, lesson) => CarouselCell(
                      lesson: lesson,
                      index: index,
                      locked: !userStore.user.isPremium && 3 <= index,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SectionSelectPage(lesson: lesson),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),

          const GFTypography(
            text: 'Favorite',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.DANGER,
          ),

          FutureBuilder<List<Phrase>>(
            future: lessonNotifier.favoritePhrases(),
            builder: (_, res) {
              if (!res.hasData || res.data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'no favorites',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
              } else {
                return Column(
                  children: [
                    PhraseCard(
                      phrase: res.data.first,
                      favorite: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => FavoritePage()),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),

          // New Coming Phrases Section
          const GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ),

          FutureBuilder<List<Phrase>>(
              future: lessonNotifier.newComingPhrases(),
              builder: (_, res) {
                if (!res.hasData || res.data.isEmpty) {
                  return const Text('no new coming phrases');
                } else {
                  final p = res.data.first;
                  return Column(
                    children: [
                      PhraseCard(
                        phrase: p,
                        favorite: userStore.user.isFavoritePhrase(p),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FavoritePage()),
                          );
                        },
                      ),
                    ],
                  );
                }
              }),

          // Request Section
          const GFTypography(
            text: 'Request',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SECONDARY,
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => RequestPage()),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 90),
                child: Text(I.of(context).requestPhraseButton),
              ),
            ),
          ).p_1(),
        ],
      ).p_1(),
    );
  }
}
