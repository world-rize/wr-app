import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/lesson/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

void main() {
  var store = MockFirestoreInstance();
  var repo = FavoriteRepository(store: store);
  const userUuid = 'test';
  var uc = store.latest.collection('users');
  var fc = uc.doc(userUuid).collection('favorites');

  setUp(() async {
    store = MockFirestoreInstance();
    repo = FavoriteRepository(store: store);
    uc = store.latest.collection('users');
    fc = uc.doc(userUuid).collection('favorites');

    final initialUser = User.create()..uuid = userUuid;
    print('setup');

    await uc.doc(initialUser.uuid).set(initialUser.toJson());
    final list = FavoritePhraseList.create(title: '', isDefault: true);
    await fc.doc(list.id).set(list.toJson());
    print((await fc.get()).docs.map((e) => e.data()).toList());
  });

  tearDown(() async {
    await fc.get().then((element) {
      Future.forEach(element.docs, (QueryDocumentSnapshot e) async {
        print(e.data());
        await e.reference.delete();
      });
    });
    await uc.doc(userUuid).delete();
    print((await fc.get()).docs.map((e) => e.data()).toList());
  });

  group('FavoriteRepository', () {
    test('getAllFavoriteLists', () async {
      final lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      print(lists);
      expect(lists.length, 1);
      expect(lists[0].isDefault, true);
    });

    test('findById', () async {
      final lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      print(lists);
      final l = await repo.findById(userUuid: userUuid, listUuid: lists[0].id);
      expect(lists[0].id, l.id);
    });

    test('deleteFavoriteList', () async {
      var lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      print(lists);
      expect(lists.length, 1);
      final l = await repo.deleteFavoriteList(
          userUuid: userUuid, listUuid: lists[0].id);
      expect(l.isDefault, true);
      lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      print(lists);
      expect(lists.length, 0);
    });

    test('createFavoriteList', () async {
      final l = await repo.createFavoriteList(
          userUuid: userUuid, isDefault: false, title: 'hgoe');
      final lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      print(lists);
      expect(lists.length, 2);
    });

    test('updateFavoriteList', () async {
      var l = await repo.createFavoriteList(
        userUuid: userUuid,
        isDefault: false,
        title: 'hgoe',
      );
      l.title = 'fff';
      l = await repo.updateFavoriteList(
        userUuid: userUuid,
        list: l,
      );
      final lists = await repo.getAllFavoriteLists(userUuid: userUuid);
      expect(
        lists
            .firstWhere((element) => element.title == 'fff', orElse: () => null)
            .title,
        'fff',
      );
    });
  });
}
