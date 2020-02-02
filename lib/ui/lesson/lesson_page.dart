// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/section.dart';
import 'package:wr_app/ui/lesson/widgets/phrase_widget.dart';
import 'package:wr_app/ui/lesson/widgets/gf_rect_items_carousel.dart';

final List<Lesson> _dummyLessons = List<Lesson>.generate(
    6,
    (i) => Lesson(
        'School$i', 'https://source.unsplash.com/category/nature/300x800'));

class LessonPage extends StatelessWidget {
  Widget _createLessonSelectCarousel(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GFRectItemsCarousel(
      rowCount: 3,
      height: size.height.round(),
      children: _dummyLessons.map(
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

  @override
  Widget build(BuildContext context) {
    var _dummyPhrase = Phrase(
      english: 'When is the homework due?',
      japanese: 'いつ宿題するんだっけ',
    );

    return SingleChildScrollView(
      child: Padding(
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
              child: _createLessonSelectCarousel(context),
            ),

            GFTypography(
              text: 'Favorite',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.danger,
            ),

            PhraseView(context, _dummyPhrase),

            // New Coming Phrases Section
            GFTypography(
              text: 'New coming phrases',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.success,
            ),

            PhraseView(context, _dummyPhrase),

            // Request Section
            GFTypography(
              text: 'Request',
              type: GFTypographyType.typo1,
              dividerColor: GFColor.secondary,
            ),

            // TODO: Request
            const Placeholder(
              fallbackHeight: 150.0,
            ),
          ],
        ),
      ),
    );
  }
}
