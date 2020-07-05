// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/store/article_repository.dart';
import 'package:wr_app/store/logger.dart';

class ArticleStore extends ChangeNotifier {
  /// シングルトンインスタンス
  static ArticleStore _cache;

  factory ArticleStore({@required Client client}) {
    return _cache ??= ArticleStore._internal(client: client);
  }

  ArticleStore._internal({@required Client client}) {
    repo = ArticleRepository(client);
    InAppLogger.log('[ArticleStore] init');
  }

  // repo
  ArticleRepository repo;
}
