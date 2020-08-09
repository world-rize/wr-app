// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/util/extensions.dart';

import './favorite_page.dart';
import './newcoming_page.dart';
import './request_page.dart';
import './section_select_page.dart';
import '../widgets/carousel_cell.dart';
import '../widgets/phrase_widget.dart';

/// Lesson > index
/// - top page of lesson
class LessonIndexPage extends StatelessWidget {
//  Future<void> _sendAnalyticsEvent(BuildContext context) async {
//    final userStore = Provider.of<UserNotifier>(context);
//    if (userStore == null) {
//      return;
//    }
//    final analytics = Provider.of<FirebaseAnalytics>(context);
//    await analytics.logEvent(
//      name: 'test_event',
//      parameters: {
//        'uid': userStore.user.uuid,
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserNotifier>(context);
    final user = userStore.getUser();
    final lessonNotifier = Provider.of<LessonNotifier>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Header1(
            text: 'Lesson',
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
                      locked: !user.isPremium && 3 <= index,
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

          const Header1(
            text: 'Favorite',
            dividerColor: GFColors.DANGER,
          ),

          FutureBuilder<List<Phrase>>(
            future: lessonNotifier.favoritePhrases(),
            builder: (_, res) {
              if (!res.hasData || res.data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No favorites',
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
          const Header1(
            text: 'New coming phrases',
            dividerColor: GFColors.SUCCESS,
          ),

          FutureBuilder<List<Phrase>>(
            future: lessonNotifier.newComingPhrases(),
            builder: (_, res) {
              if (!res.hasData || res.data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No new coming phrases',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
              } else {
                final p = res.data.first;
                return Column(
                  children: [
                    PhraseCard(
                      phrase: p,
                      favorite: user.isFavoritePhrase(p.id),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => NewComingPage()),
                        );
                      },
                      onFavorite: () {
                        userStore.favoritePhrase(
                          phraseId: p.id,
                          favorite: !user.isFavoritePhrase(p.id),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),

          // Request Section
          const Header1(
            text: 'Request',
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
