// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/article/index.dart';

abstract class IArticleRepository {
  List<ArticleCategory> getCategories();
}
