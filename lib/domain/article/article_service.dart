// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/article/article_repository.dart';

class ArticleService {
  final ArticleRepository _articleRepository;

  const ArticleService({
    @required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  Future<List<Article>> findByCategory({
    @required Client client,
    @required String id,
  }) {
    return _articleRepository.findByCategory(client: client, id: id);
  }
}
