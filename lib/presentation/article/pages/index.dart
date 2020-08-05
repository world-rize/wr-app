// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/presentation/article/pages/category_posts_page.dart';
import 'package:wr_app/presentation/article/widgets/category_view.dart';
import 'package:wr_app/ui/widgets/admob_widget.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/util/extensions.dart';

/// Column > index
class ColumnIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ArticleNotifier>(context);
    final categories = notifier.getCategories();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header1(text: 'Column', dividerColor: GFColors.SUCCESS).p_1(),
          // categories
          ...categories.map(
            (category) => CategoryView(
              category: category,
              onTap: (article) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoryPosts(category: category),
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
