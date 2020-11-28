// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/i10n/i10n.dart';
import 'package:wr_app/presentation/extensions.dart';
import 'package:wr_app/presentation/lesson/notifier/lesson_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/ui/widgets/shadowed_container.dart';
import 'package:wr_app/usecase/lesson_service.dart';
import 'package:wr_app/util/extensions.dart';
import 'package:wr_app/util/logger.dart';

import './favorite_page.dart';
import './newcoming_page.dart';
import './request_page.dart';
import './section_select_page.dart';
import '../widgets/carousel_cell.dart';
import '../widgets/phrase_card.dart';

class LessonIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final lessonService = GetIt.I<LessonService>();

    return ChangeNotifierProvider.value(
      value: LessonNotifier(
        user: un.user,
        lessonService: lessonService,
      ),
      child: _LessonIndexPage(),
    );
  }
}


/// Lesson > index
/// - top page of lesson
class _LessonIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final un = Provider.of<UserNotifier>(context);
    final user = un.user;
    final ln = Provider.of<LessonNotifier>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Header1(
            text: I.of(context).lessonPageTitle,
            dividerColor: GFColors.PRIMARY,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: GFCarousel(
              enableInfiniteScroll: false,
              items: ln
                  .getAllLessons()
                  .indexedMap(
                    (index, lesson) => CarouselCell(
                      lesson: lesson,
                      index: index,
                      locked: ln.isLessonLocked(user, lesson),
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
            future: ln.getFavoritePhrases(user),
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
          Header1(
            text: I.of(context).newComingPageTitle,
            dividerColor: GFColors.SUCCESS,
          ),

          FutureBuilder<List<Tuple2<Phrase, bool>>>(
            future: ln.newComingPhrases().then((value) async {
              return await Future.forEach(value, (element) async {
                return Tuple2(
                    element,
                    await ln.existPhraseInFavoriteList(
                        user: user, phraseId: element));
              });
            }),
            builder: (_, res) {
              if (!res.hasData || res.data.isEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                  child: Text(
                    I.of(context).noNewComingPhraseMessage,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                );
              } else {
                final p = res.data.first;
                return Column(
                  children: [
                    PhraseCard(
                      phrase: p.item1,
                      favorite: p.item2,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => NewComingPage()),
                        );
                      },
                      onFavorite: () async {
                        await ln.favoritePhrase(
                          phraseId: p.item1.id,
                          favorite: !await ln.existPhraseInFavoriteList(
                            phraseId: p.item1.id,
                            user: user,
                          ),
                          user: user,
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),

          // Request Section
          Header1(
            text: I.of(context).requestPageTitle,
            dividerColor: GFColors.SECONDARY,
          ),

          ShadowedContainer(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RequestPage()),
                  );
                },
                child: Center(
                    child: Text(
                  I.of(context).requestPhraseButton,
                  style: Theme.of(context).textTheme.headline5,
                )),
              ),
            ),
          ),
        ],
      ).padding(),
    );
  }
}
