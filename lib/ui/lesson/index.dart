// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';

import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';

import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/lesson/widgets/gf_rect_items_carousel.dart';

// TODO: Brush up
class LessonSelectCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GFRectItemsCarousel(
      rowCount: 3,
      height: size.height.round(),
      children: MasterDataStore.dummyLessons.map(
        (lesson) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SectionSelectPage()),
              );
            },
            child: Container(
              height: size.height,
              width: size.width,
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      lesson.thumbnailUrl,
                      fit: BoxFit.cover,
                      height: size.height,
                      width: size.width,
                    ),
                    Text(lesson.title,
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class LessonMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<UserStore>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          GFTypography(
            text: 'Lesson',
            type: GFTypographyType.typo1,
            dividerColor: GFColor.primary,
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: LessonSelectCarousel(),
          ),

          GFTypography(
            text: 'Favorite',
            type: GFTypographyType.typo1,
            dividerColor: GFColor.danger,
          ),

          PhraseView(context, store.pickedUpFavoritePhrase),

          // New Coming Phrases Section
          GFTypography(
            text: 'New coming phrases',
            type: GFTypographyType.typo1,
            dividerColor: GFColor.success,
          ),

          PhraseView(context, store.pickedUpNewComingPhrase),

          // Request Section
          GFTypography(
            text: 'Request',
            type: GFTypographyType.typo1,
            dividerColor: GFColor.secondary,
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: InkWell(
                onTap: () {
                  // TODO Request Page
                },
                child: Padding(
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

class LessonIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<UserStore>(
      create: (context) => UserStore(),
      child: SingleChildScrollView(
        child: LessonMenus(),
      ),
    );
  }
}
