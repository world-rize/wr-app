// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/api/mock.dart';
import 'package:wr_app/ui/column/category_posts.dart';
import 'package:wr_app/ui/column/category_view.dart';

/// `コラム` ページのトップ
///
// TODO(anyone): fix
class ColumnIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: GFTypography(
              text: 'Column',
              type: GFTypographyType.typo1,
              dividerColor: GFColors.SUCCESS,
            ),
          ),
          ...dummyCategories(5)
              .map(
                (category) => CategoryView(
                  category: category,
                  onTap: (article) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryPosts(
                        category: category,
                        articles: dummyArticles(10),
                        onTap: (article) {},
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
