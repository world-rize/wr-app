// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/model/article.dart';

abstract class IArticleRepository {
  Future<List<Article>> findByCategory(Client client, String category);
}

class ArticleRepository implements IArticleRepository {
  @override
  Future<List<Article>> findByCategory(Client client, String category) async {
    final collection = await client.getEntries<Article>({
      'content_type': 'article',
      'fields.category': category,
    }, Article.fromJson);

    return collection.items;
  }
}
