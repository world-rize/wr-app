// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/domain/article/model/category.dart';
import 'package:wr_app/infrastructure/article/article_repository.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/presentation/article/pages/english_lesson_pr_page.dart';
import 'package:wr_app/presentation/article/widgets/category_view.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/usecase/article_service.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';

class ArticleIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArticleNotifier>(
      create: (_) => ArticleNotifier(
        articleService: ArticleService(
          articleRepository: ArticleRepository(),
        ),
      ),
      child: _IndexPage(),
    );
  }
}

/// Article > index
class _IndexPage extends StatelessWidget {
  Future onTapCategory(ArticleCategory category) async {
    if (await canLaunch(category.url)) {
      await launch(
        category.url,
        forceSafariVC: false,
        forceWebView: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryCards = [
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
        (category) => CategoryView(category: category, onTap: onTapCategory),
      ),
    ];

    final env = GetIt.I<EnvKeys>();
    final adsBanner = AdmobBanner(
      adUnitId: env.admobBannerAdUnitId,
      adSize: AdmobBannerSize.LEADERBOARD,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header1(text: 'Column', dividerColor: GFColors.SUCCESS)
              .padding(),
          ...categoryCards,
          adsBanner,
        ],
      ),
    );
  }
}
