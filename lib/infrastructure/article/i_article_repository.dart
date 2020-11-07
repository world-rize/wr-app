// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:wr_app/domain/article/index.dart';

abstract class IArticleRepository {
  Future<List<ArticleDigest>> findByCategory(Client client, String category);
  List<ArticleCategory> getCategories();
}
