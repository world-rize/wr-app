// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/model.dart';

class ArticleService {
  final ArticleRepository _articleRepository;

  const ArticleService({
    @required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  Future<List<Article>> findByCategory({
    @required Client client,
    @required String id,
  }) {
    return _articleRepository.findByCategory(client, id);
  }

  List<ArticleCategory> getCategories() {
    return _articleRepository.getCategories();
  }
}
