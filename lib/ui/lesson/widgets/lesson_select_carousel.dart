// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/extension/collection_extension.dart';
import 'package:wr_app/store/masterdata.dart';
import 'package:wr_app/store/user.dart';
import 'package:wr_app/ui/lesson/section_select_page.dart';
import 'package:wr_app/ui/lesson/widgets/carousel_cell.dart';

/// レッスン選択カルーセル
class LessonSelectCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPremium = Provider.of<UserStore>(context).isPremium;
    final masterData = Provider.of<MasterDataStore>(context);
    final lessons = masterData.getLessons();

    return GFCarousel(
      enableInfiniteScroll: false,
      items: lessons
          .indexedMap(
            (index, lesson) => CarouselCell(
              lesson: lesson,
              index: index,
              locked: !isPremium && 3 <= index,
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
    );
  }
}
