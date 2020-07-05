// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/api/mock.dart';
import 'package:wr_app/extension/padding_extension.dart';
import 'package:wr_app/ui/column/article_detail_page.dart';
import 'package:wr_app/ui/column/category_posts.dart';
import 'package:wr_app/ui/column/category_view.dart';
import 'package:wr_app/ui/common/admob_widget.dart';

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
          const GFTypography(
            text: 'Column',
            type: GFTypographyType.typo1,
            dividerColor: GFColors.SUCCESS,
          ).p_1(),
          // categories
          ...categories.map(
            (category) => CategoryView(
              category: category,
              onTap: (article) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoryPosts(
                    category: category,
                    onTap: (article) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleDetailPage(article: article),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const AdmobBannerWidget(),
        ],
      ),
    );
  }
}
