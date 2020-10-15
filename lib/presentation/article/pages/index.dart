// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/article/model/category.dart';
import 'package:wr_app/presentation/article/pages/english_lesson_pr_page.dart';
import 'package:wr_app/presentation/article/widgets/category_view.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/usecase/article_service.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';

/// Column > index
/// TODO: ファイル名をcolumnにしたい

class ColumnIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _ArticleNotifier(
        articleService: GetIt.I<ArticleService>(),
      ),
      child: _ColumnIndexPage(),
    );
  }
}

class _ArticleNotifier extends ChangeNotifier {
  _ArticleNotifier({
    @required ArticleService articleService,
  }) : _articleService = articleService;

  ArticleService _articleService;

  List<ArticleCategory> getCategories() {
    return _articleService.getCategories();
  }
}

class _ColumnIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    final an = Provider.of<_ArticleNotifier>(context);
    final categories = an.getCategories();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header1(text: 'Column', dividerColor: GFColors.SUCCESS)
              .padding(),
          // English lesson
          CategoryView(
            category: ArticleCategory(
              id: 'online_lesson',
              title: 'オンライン英会話',
              thumbnailUrl: 'assets/thumbnails/english.jpg',
              url: '',
            ),
            onTap: (_) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EnglishLessonPrPage(),
                ),
              );
            },
          ),
          // categories
          ...categories.map(
            (category) => CategoryView(
                category: category,
                onTap: (_) async {
                  if (await canLaunch(category.url)) {
                    await launch(
                      category.url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  }

                  // TODO
//                  Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (_) => CategoryPosts(category: category),
//                    ),
//                  );
                }),
          ),
          // admob banner
          AdmobBanner(
            adUnitId: env.admobBannerAdUnitId,
            adSize: AdmobBannerSize.LEADERBOARD,
          ),
        ],
      ),
    );
  }
}
