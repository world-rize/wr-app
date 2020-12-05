import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/shop/shop_repository.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';
import 'package:wr_app/usecase/shop_service.dart';

import '../util/test_util.dart';

void main() {
  var store = MockFirestoreInstance();
  var repo = ShopRepository(store: store);
  var service = ShopService(shopRepository: repo);

  const userUuid = 'test';
  final dummyItem = ShopItem(
    id: 'item1',
    title: 'アイテム1',
    description: '',
    price: 100,
    expendable: false,
  );

  setUp(() async {
    store = MockFirestoreInstance();
    repo = ShopRepository(store: store);
    service = ShopService(shopRepository: repo);
    final initialUser = User.create()
      ..uuid = userUuid
      ..points = 1000;

    await store.collection('shop').doc(dummyItem.id).set(dummyItem.toJson());

    await store.latest
        .collection('users')
        .doc(initialUser.uuid)
        .set(initialUser.toJson());
  });

  group('ShopRepository', () {
    test('shopItems', () async {
      final items = await service.getShopItems();
      expect(items.length, 1);
    });

    test('purchaseItem', () async {
      final user = await store.getDummyUser();
      await service.purchaseItem(user: user, itemId: dummyItem.id);
      final receipts = await service.getAllReceipts(userUuid);
      expect(receipts[0].count, 1);
      expect(receipts[0].itemId, dummyItem.id);
    });

    test('filterById', () async {
      final user = await store.getDummyUser();
      await service.purchaseItem(user: user, itemId: dummyItem.id);
      await service.purchaseItem(user: user, itemId: dummyItem.id);
      final receipts =
          await repo.filterByItemId(userUuid: user.uuid, itemId: dummyItem.id);
      expect(receipts[0].count, 1);
      expect(receipts[0].itemId, dummyItem.id);
      expect(receipts.length, 2);
    });
  });
}
