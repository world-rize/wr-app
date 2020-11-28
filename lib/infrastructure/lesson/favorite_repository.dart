import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/infrastructure/lesson/i_favorite_repository.dart';

class FavoriteRepository implements IFavoriteRepository {
  const FavoriteRepository({@required this.store});

  final FirebaseFirestore store;

  Future<DocumentReference> _favoritesDoc({
    @required String userUuid,
    @required String listUuid,
  }) async {
    return (await store
            .collection('versions')
            .where('version', isEqualTo: 'v1')
            .limit(1)
            .get())
        .docs[0]
        .reference
        .collection('users')
        .doc(userUuid)
        .collection('favorites')
        .doc(listUuid);
  }

  @override
  Future<List<FavoritePhraseList>> getAllFavoriteLists(
      {String userUuid}) async {
    return (await store
            .collection('users')
            .doc(userUuid)
            .collection('favorites')
            .get())
        .docs
        .map((e) => FavoritePhraseList.fromJson(e.data()))
        .toList();
  }

  // FIXME: 見つからなかったときどうなるのか
  @override
  Future<FavoritePhraseList> findById({
    @required String userUuid,
    @required String listUuid,
  }) async {
    return FavoritePhraseList.fromJson(
        (await (await _favoritesDoc(userUuid: userUuid, listUuid: listUuid))
                .get())
            .data());
  }

  @override
  Future<FavoritePhraseList> deleteFavoriteList({
    @required String userUuid,
    @required String listUuid,
  }) async {
    final target = FavoritePhraseList.fromJson(
        (await (await _favoritesDoc(userUuid: userUuid, listUuid: listUuid))
                .get())
            .data());
    await (await _favoritesDoc(userUuid: userUuid, listUuid: listUuid))
        .delete();
    return target;
  }

  @override
  Future<FavoritePhraseList> createFavoriteList({
    @required String userUuid,
    @required String title,
    @required bool isDefault,
  }) async {
    final list = FavoritePhraseList.create(title: title, isDefault: isDefault);
    await (await _favoritesDoc(userUuid: userUuid, listUuid: list.id))
        .set(list.toJson());
    return list;
  }

  @override
  Future<FavoritePhraseList> updateFavoriteList({
    @required String userUuid,
    @required FavoritePhraseList list,
  }) async {
    await (await _favoritesDoc(userUuid: userUuid, listUuid: list.id))
        .set(list.toJson());
    return list;
  }
}
