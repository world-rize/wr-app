// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/model/lesson.dart';
import 'package:wr_app/ui/lesson/request_page.dart';

import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';

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

          Column(
            children: masterData
                .allPhrases()
                .where((phrase) =>
                    userStore.user.favorites.containsKey(phrase.id) &&
                    userStore.user.favorites[phrase.id])
                .map((phrase) => phraseView(context, phrase))
                .toList(),
          ),

          // New Coming Phrases Section
          const GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ),

          Column(
            children: masterData
                .allPhrases()
                // TODO
                .where((phrase) => phrase.id.endsWith('5'))
                .map((phrase) => phraseView(context, phrase))
                .toList(),
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 90),
                  child: Text('フレーズをリクエストする'),
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

  Widget _carouselCell(BuildContext context, Lesson lesson) {
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
              const Positioned(
                top: 10,
                left: 10,
                child: Text('No.1',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
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
                child: Text('クリア[0/${lesson.phrases.length}]',
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
      items: lessons.map((lesson) => _carouselCell(context, lesson)).toList(),
//      onPageChanged: (index) {
//        setState(() {
//          index;
//        });
//      },
    );

//    return GFRectItemsCarousel(
//      rowCount: 3,
//      height: size.height.round(),
//      children: MasterDataStore.dummyLessons.map(
//        (lesson) {
//          return GestureDetector(
//            onTap: () {
//              Navigator.of(context).push(
//                MaterialPageRoute(builder: (_) => SectionSelectPage()),
//              );
//            },
//            child: Container(
//              height: size.height,
//              width: size.width,
//              margin: const EdgeInsets.all(5),
//              child: ClipRRect(
//                borderRadius: const BorderRadius.all(Radius.circular(5)),
//                child: Stack(
//                  children: <Widget>[
//                    Image.network(
//                      lesson.assets.img['thumbnail'],
//                      fit: BoxFit.cover,
//                      height: size.height,
//                      width: size.width,
//                    ),
//                    Text(lesson.title['ja'],
//                        style: TextStyle(color: Colors.white, fontSize: 30)),
//                  ],
//                ),
//              ),
//            ),
//          );
//        },
//      ).toList(),
//    );
  }
}
