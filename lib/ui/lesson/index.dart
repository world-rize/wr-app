// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/i10n/i10n.dart';

import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/ui/lesson/favorite_page.dart';
import 'package:wr_app/ui/lesson/request_page.dart';

import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

extension IndexedMap<T, E> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}

/// `レッスン` ページのトップ
///
class LessonIndexPage extends StatelessWidget {
  Future<void> _sendAnalyticsEvent(BuildContext context) async {
    final userStore = Provider.of<UserStore>(context);
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
    return SingleChildScrollView(
      child: LessonMenus(),
    );
  }
}

/// ページの中身
class LessonMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final masterData = Provider.of<MasterDataStore>(context);

    final favoritePhrase = masterData.allPhrases().firstWhere(
        (phrase) =>
            userStore.user.favorites.containsKey(phrase.id) &&
            userStore.user.favorites[phrase.id],
        orElse: () => null);

    // TODO(someone): call api
    final newComingPhrase = masterData
        .allPhrases()
        .firstWhere((phrase) => phrase.id.endsWith('5'), orElse: () => null);

    return Padding(
      padding: const EdgeInsets.all(12),
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
            child: LessonSelectCarousel(),
          ),

          const GFTypography(
            text: 'Favorite',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.DANGER,
          ),

          if (favoritePhrase != null)
            Column(
              children: [
                phraseView(
                  context,
                  favoritePhrase,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => FavoritePage()),
                    );
                  },
                ),
              ],
            ),

          // New Coming Phrases Section
          const GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ),

          if (newComingPhrase != null)
            Column(
              children: [
                phraseView(
                  context,
                  favoritePhrase,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => FavoritePage()),
                    );
                  },
                ),
              ],
            ),

          // Request Section
          const GFTypography(
            text: 'Request',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SECONDARY,
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
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
            ),
          ),
        ],
      ),
    );
  }
}

/// レッスン選択カルーセル
class LessonSelectCarousel extends StatelessWidget {
//  Widget __carouselCell(Lesson lesson) {
//    return Container(
//      margin: const EdgeInsets.all(8),
//      child: ClipRRect(
//        borderRadius: const BorderRadius.all(Radius.circular(5)),
//        child: Image.network(lesson.assets.img['thumbnail'],
//            fit: BoxFit.cover, width: 1000),
//      ),
//    );
//  }

  Widget _carouselCell(BuildContext context, Lesson lesson, int index) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SectionSelectPage(lesson: lesson)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Stack(
            children: <Widget>[
              Image.asset(
                lesson.assets.img['thumbnail'],
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
              ClipRect(
                child: Container(
                  color: const Color.fromRGBO(128, 128, 128, 0.5),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Text('No.${index + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    lesson.title['ja'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: Text(
                    I.of(context).lessonStatus(0, lesson.phrases.length),
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final masterData = Provider.of<MasterDataStore>(context);
    final lessons = masterData.getLessons();

    return GFCarousel(
      enableInfiniteScroll: false,
      items: lessons
          .indexedMap((i, lesson) => _carouselCell(context, lesson, i))
          .toList(),
    );
  }
}
