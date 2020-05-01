// Copyright © 2020 WorldRIZe. All rights reserved.

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
    final store = Provider.of<UserStore>(context);

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

          phraseView(context, store.pickedUpFavoritePhrase),

          // New Coming Phrases Section
          const GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ),

          phraseView(context, store.pickedUpNewComingPhrase),

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
//              Image.asset(
//                lesson.assets.img['thumbnail'],
//                fit: BoxFit.cover,
//                height: size.height,
//                width: size.width,
//              ),
              Image.network(
                'https://source.unsplash.com/random/300x800',
                // lesson.assets.img['thumbnail'],
                fit: BoxFit.cover,
                height: size.height,
                width: size.width,
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(lesson.title['ja'],
                    style: const TextStyle(color: Colors.white, fontSize: 40)),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text('XXX / ${lesson.phrases.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 30)),
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
