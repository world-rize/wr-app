// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/article/index.dart';

class ArticleService {
  ArticleService({
    @required ArticleRepository articlePersistence,
  }) : _articlePersistence = articlePersistence;

  final ArticleRepository _articlePersistence;

  List<ArticleCategory> getCategories() {
    return _articlePersistence.getCategories();
  }
}
