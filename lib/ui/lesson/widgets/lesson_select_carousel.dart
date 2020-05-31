// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';

import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/model/lesson.dart';

import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/carousel_cell.dart';
import 'package:wr_app/extension/collection_extension.dart';

/// レッスン選択カルーセル
class LessonSelectCarousel extends StatelessWidget {
  Widget _carouselCell(BuildContext context, Lesson lesson, int index) {
    return CarouselCell(
      lesson: lesson,
      index: index,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SectionSelectPage(lesson: lesson),
          ),
        );
      },
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
