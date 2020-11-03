// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';

class ArticleService {
  final ArticleRepository _articlePersistence;

  const ArticleService({
    required ArticleRepository articlePersistence,
  }) : _articlePersistence = articlePersistence;

  Future<List<ArticleDigest>> findByCategory({
    required Client client,
    required String id,
  }) {
    return _articlePersistence.findByCategory(client, id);
  }

  List<ArticleCategory> getCategories() {
    return _articlePersistence.getCategories();
  }
}
