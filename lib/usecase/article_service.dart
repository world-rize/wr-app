// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';

class ArticleService {
  factory ArticleService({
    @required ArticleRepository articlePersistence,
  }) {
    return _cache ??= ArticleService._(articlePersistence: articlePersistence);
  }

  ArticleService._({
    @required ArticleRepository articlePersistence,
  }) : _articlePersistence = articlePersistence;

  static ArticleService _cache;
  final ArticleRepository _articlePersistence;

  Future<List<ArticleDigest>> findByCategory({
    @required Client client,
    @required String id,
  }) {
    return _articlePersistence.findByCategory(client, id);
  }

  List<ArticleCategory> getCategories() {
    return _articlePersistence.getCategories();
  }
}
