// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/article_service.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/util/logger.dart';

class ArticleNotifier extends ChangeNotifier {
  ArticleService _articleService;

  Client _client;

  /// singleton
  static ArticleNotifier _cache;

  factory ArticleNotifier({
    @required ArticleService articleService,
    @required Client client,
  }) {
    return _cache ??= ArticleNotifier._internal(
        articleService: articleService, client: client);
  }

  ArticleNotifier._internal({
    @required ArticleService articleService,
    @required Client client,
  }) {
    _articleService = articleService;
    _client = client;
    InAppLogger.log('[ArticleStore] init');
  }

  Future<List<ArticleDigest>> findByCategory({
    @required String id,
  }) {
    return _articleService.findByCategory(client: _client, id: id);
  }

  List<ArticleCategory> getCategories() {
    return _articleService.getCategories();
  }
}
