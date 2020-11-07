// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/infrastructure/article/i_article_repository.dart';

class ArticleService {
  const ArticleService({
    @required IArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  final IArticleRepository _articleRepository;

  Future<List<ArticleDigest>> findByCategory({
    @required Client client,
    @required String id,
  }) {
    return _articleRepository.findByCategory(client, id);
  }

  List<ArticleCategory> getCategories() {
    return _articleRepository.getCategories();
  }
}
