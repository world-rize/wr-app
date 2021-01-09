// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/model/shop_item_v1.dart';
import 'package:wr_app/domain/shop/model/shop_item_v2.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_v1.dart';
import 'package:wr_app/domain/user/model/user_v2.dart';
import 'package:wr_app/util/migrations.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

void main() {
  final store = MockFirestoreInstance();
  final migrationExecutor = MigrationExecutor(store: store);
  final v0Ref = store.version('v0');
  final v1Ref = store.version('v1');
  final v2Ref = store.version('v2');
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

    final items = ['item1', 'item2'].map((id) => ShopItem(
          id: id,
          title: id,
          description: '',
          price: 0,
          expendable: false,
        ));

    await v0Ref.collection('users').add(userV0.toJson());

    for (final item in items) {
      await v0Ref.collection('items').add(item.toJson());
    }
  });

  group('Migration', () {
    test('user data migration', () async {
      print(store.dump());

      await migrationExecutor.migrateUserData(uid);

      final userV1ss = await v1Ref.collection('users').doc(uid).get();
      expect(userV1ss.exists, true);
      final userV1 = UserV1.fromJson(userV1ss.data());
      expect(userV1.nameUpperCase, 'TEST');

      final userV2ss = await v2Ref.collection('users').doc(uid).get();
      expect(userV2ss.exists, true);
      final userV2 = UserV2.fromJson(userV2ss.data());
      expect(userV2.nameReversed, 'TSET');
    });

    test('master data migration', () async {
      print(store.dump());

      await migrationExecutor.migrateMasterData();

      final itemV1ss = await v1Ref.collection('items').doc('item1').get();
      expect(itemV1ss.exists, true);
      final itemV1 = ShopItemV1.fromJson(itemV1ss.data());
      expect(itemV1.titleUpperCase, 'ITEM1');

      final itemV2ss = await v2Ref.collection('items').doc('item1').get();
      expect(itemV2ss.exists, true);
      final itemV2 = ShopItemV2.fromJson(itemV2ss.data());
      expect(itemV2.titleReversed, '1METI');
    });
  });
}
