// Copyright © 2020 WorldRIZe. All rights reserved.

class ArticleNotifier extends ChangeNotifier {
  /// singleton
  static ArticleStore _cache;

  factory ArticleStore({@required Client client}) {
    return _cache ??= ArticleStore._internal(client: client);
  }

  ArticleStore._internal({@required Client client}) {
    repo = ArticleRepository(client);
    InAppLogger.log('[ArticleStore] init');
  }
}
