// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_v1.dart';
import 'package:wr_app/domain/note/model/note_v2.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/model/shop_item_v1.dart';
import 'package:wr_app/domain/shop/model/shop_item_v2.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_v1.dart';
import 'package:wr_app/domain/user/model/user_v2.dart';
import 'package:wr_app/util/migrations.dart';
import '../util/test_util.dart';

void main() {
  final store = MockFirestoreInstance();
  final migrationExecutor = MigrationExecutor(store: store);
  const uid = 'test';

  setUp(() async {
    print('setup');

    ///
    /// /versions/
    /// |_ v0/
    ///   |- users/ (user data User)
    ///     |- test
    ///   |- items/ (master data ShopItem)
    /// |- v1/
    ///   |- users/ (user data UserV1)
    ///   |- items/ (master data ShopItemV1)
    /// |- v2
    ///   |- users/ (user data UserV2)
    ///   |- items/ (master data ShopItemV2)
    final userV0 = User.create()
      ..uuid = uid
      ..name = uid;

    final notes =
        ['note1', 'note2'].map((id) => Note.create(title: id)..id = id);

    final items = ['item1', 'item2'].map((id) => ShopItem(
          id: id,
          title: id,
          description: '',
          price: 0,
          expendable: false,
        ));

    await store.set('v0/users/$uid', userV0.toJson());

    for (final note in notes) {
      await store.set('v0/users/$uid/notes/${note.id}', note.toJson());
    }

    for (final item in items) {
      await store.set('v0/items/${item.id}', item.toJson());
    }
  });

  group('Migration', () {
    test('user data migration', () async {
      await migrationExecutor.migrateUserData(uid);

      expect(
          (await store.get<UserV1>('v1/users/$uid', (json) => UserV1.fromJson(json))).nameUpperCase,
          'TEST'
      );
      expect(
          (await store.get<UserV2>('v2/users/$uid', (json) => UserV2.fromJson(json))).nameReversed,
          'TSET'
      );
      expect(
          (await store.get<NoteV1>('v1/users/$uid/notes/note1', (json) => NoteV1.fromJson(json))).titleUpperCase,
          'NOTE1'
      );
      expect(
          (await store.get<NoteV2>('v2/users/$uid/notes/note1', (json) => NoteV2.fromJson(json))).titleReversed,
          '1ETON'
      );
    });

    test('master data migration', () async {
      await migrationExecutor.migrateMasterData();

      expect(
          (await store.get<ShopItemV1>('v1/items/item1', (json) => ShopItemV1.fromJson(json))).titleUpperCase,
          'ITEM1'
      );
      expect(
          (await store.get<ShopItemV2>('v2/items/item1', (json) => ShopItemV2.fromJson(json))).titleReversed,
          '1METI'
      );
    });
  });
}
