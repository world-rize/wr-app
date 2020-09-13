// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/getflutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/presentation/article/widgets/category_view.dart';
import 'package:wr_app/ui/widgets/header1.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/extensions.dart';

/// Column > index
class ColumnIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final env = GetIt.I<EnvKeys>();
    final an = Provider.of<ArticleNotifier>(context);
    final categories = an.getCategories();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header1(text: 'Column', dividerColor: GFColors.SUCCESS)
              .padding(),
          // categories
          ...categories.map(
            (category) => CategoryView(
                category: category,
                onTap: (article) async {
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
