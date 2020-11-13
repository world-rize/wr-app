// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/usecase/article_service.dart';

class ArticleNotifier extends ChangeNotifier {
  ArticleService _articleService;

  /// singleton
  static ArticleNotifier _cache;

  factory ArticleNotifier({
    @required ArticleService articleService,
  }) {
    return _cache ??= ArticleNotifier._internal(articleService: articleService);
  }

  ArticleNotifier._internal({
    @required ArticleService articleService,
  }) : _articleService = articleService;

  List<ArticleCategory> getCategories() {
    return _articleService.getCategories();
  }
}
