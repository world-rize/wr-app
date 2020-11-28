import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';

abstract class IFavoriteRepository {
  Future<List<FavoritePhraseList>> getAllFavoriteLists(
      {@required String userUuid});

  Future<FavoritePhraseList> findById({
    @required String userUuid,
    @required String listUuid,
  });

  Future<FavoritePhraseList> deleteFavoriteList({
    @required String userUuid,
    @required String listUuid,
  });

  Future<FavoritePhraseList> createFavoriteList({
    @required String userUuid,
    @required String title,
    @required bool isDefault,
  });

  Future<FavoritePhraseList> updateFavoriteList({
    @required String userUuid,
    @required FavoritePhraseList list,
  });
}
