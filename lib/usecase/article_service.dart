// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/infrastructure/article/i_article_repository.dart';

class ArticleService {
  const ArticleService({
    @required IArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  final IArticleRepository _articleRepository;

  List<ArticleCategory> getCategories() {
    return _articleRepository.getCategories();
  }
}
