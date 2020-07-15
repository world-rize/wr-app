// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/index.dart';

class ArticleService {
  final IArticleRepository _articleRepository;

  const ArticleService({
    @required IArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

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
