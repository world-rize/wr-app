import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/infrastructure/lesson/i_favorite_repository.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

class FavoriteRepository implements IFavoriteRepository {
  const FavoriteRepository({@required this.store});

  final FirebaseFirestore store;

  CollectionReference favoritesCollection({
    @required String userUuid,
  }) {
    return store.latest
        .collection('users')
        .doc(userUuid)
        .collection('favorites');
  }

  @override
  Future<List<FavoritePhraseList>> getAllFavoriteLists(
      {String userUuid}) async {
    return (await favoritesCollection(userUuid: userUuid).get())
        .docs
        .map((e) => FavoritePhraseList.fromJson(e.data()))
        .toList();
  }

  // FIXME: 見つからなかったときどうなるのか
  // たぶんnull
  @override
  Future<FavoritePhraseList> findById({
    @required String userUuid,
    @required String listUuid,
  }) async {
    return FavoritePhraseList.fromJson(
        (await favoritesCollection(userUuid: userUuid).doc(listUuid).get())
            .data());
  }

  @override
  Future<FavoritePhraseList> deleteFavoriteList({
    @required String userUuid,
    @required String listUuid,
  }) async {
    final target = FavoritePhraseList.fromJson(
        (await favoritesCollection(userUuid: userUuid).doc(listUuid).get())
            .data());
    await favoritesCollection(userUuid: userUuid).doc(listUuid).delete();
    return target;
  }

  @override
  Future<FavoritePhraseList> createFavoriteList({
    @required String userUuid,
    @required String title,
    @required bool isDefault,
  }) async {
    final list = FavoritePhraseList.create(title: title, isDefault: isDefault);
    await favoritesCollection(userUuid: userUuid)
        .doc(list.id)
        .set(list.toJson());
    return list;
  }

  @override
  Future<FavoritePhraseList> updateFavoriteList({
    @required String userUuid,
    @required FavoritePhraseList list,
  }) async {
    await favoritesCollection(userUuid: userUuid)
        .doc(list.id)
        .set(list.toJson());
    return list;
  }
}
