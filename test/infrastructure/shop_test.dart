import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/shop/shop_repository.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/util/test_util.dart';

void main() {
  final store = MockFirestoreInstance();
  final repo = ShopRepository(store: store);
  final service = ShopService(shopRepository: repo);

  const userUuid = 'test';
  final dummyItem = ShopItem(
    id: 'item1',
    title: 'アイテム1',
    description: '',
    price: 100,
    expendable: false,
  );

  setUp(() async {
    final initialUser = User.create()
      ..uuid = userUuid
      ..statistics.points = 1000;

    await store.collection('shop').doc(dummyItem.id).set(dummyItem.toJson());

    await store
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
      final diff = await snapShotDiff<User>(
        getter: store.getDummyUser,
        callback: () async {
          final u = await store.getDummyUser();
          final updated =
              await service.purchaseItem(user: u, itemId: dummyItem.id);
          await store.setDummyUser(updated);
        },
        matcher: (b, a) {
          return b.statistics.points - dummyItem.price == a.statistics.points &&
              a.items[dummyItem.id] == 1;
        },
      );
      expect(diff, true);
    });
  });
}
