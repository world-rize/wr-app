// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/typography/gf_typography.dart';
import 'package:getflutter/getflutter.dart';
import 'package:wr_app/model/article.dart';
import 'package:wr_app/model/category.dart';
import 'package:wr_app/ui/column/article_view.dart';
import 'package:wr_app/ui/column/category_posts.dart';
import 'package:wr_app/ui/column/category_view.dart';

/// `コラム` ページのトップ
///
// TODO(anyone): fix
class ColumnIndexPage extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget _titleCreate() {
    return const Placeholder();
  }

  /// カテゴリモック
  final List<Category> categories = List.generate(
    5,
    (i) => Category(
      title: 'カテゴリ$i',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
    ),
  );

  /// 記事モック
  final List<Article> articles = List.generate(
    10,
    (index) => Article(
      id: '$index',
      title: '記事$index',
      thumbnailUrl: 'https://source.unsplash.com/category/nature',
      date: DateTime.now(),
      content:
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    ),
  );

  static const _headLineStyle = TextStyle(
    fontSize: 30,
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );

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
          ...categories
              .map(
                (category) => CategoryView(
                  category: category,
                  onTap: (article) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryPosts(
                        category: category,
                        articles: articles,
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
