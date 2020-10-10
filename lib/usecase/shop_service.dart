// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/logger.dart';

/// shopに関するサービスをまとめる
class ShopService {
  factory ShopService({
    @required ShopRepository shopPersistence,
  }) {
    return _cache ??= ShopService._(shopPersistence: shopPersistence);
  }

  ShopService._({
    @required ShopRepository shopPersistence,
  }) : _shopPersistence = shopPersistence;

  static ShopService _cache;
  final ShopRepository _shopPersistence;

  /// ショップのアイテムを取得
  Future<List<GiftItem>> getShopItems() {
    return _shopPersistence.shopItems();
  }

  Future sendAmazonGiftRequest({@required String uid}) {
    return _shopPersistence.sendAmazonGiftEmail(uid);
  }

  Future sendITunesRequest({@required String uid}) {
    return _shopPersistence.sendITunesGiftEmail(uid);
  }

  /// アイテムを購入
  Future<User> purchaseItem({
    @required User user,
    @required String itemId,
  }) async {
    print('persistence ok?');
    final item = (await _shopPersistence.shopItems())
        .firstWhere((item) => item.id == itemId, orElse: () => null);

    print('pre assert');
    assert(item != null);
    assert(user != null);

    print('persistence ok');

    if (item == null) {
      print('hgoe');
      return user;
    }

    InAppLogger.debugJson(user.toJson());
    InAppLogger.debug('contenthgeojge$user');
    print('put if absent ok?');
    user.items.putIfAbsent(item.id, () => 0);
    print('put if absent ok');
    user.items[item.id] += 1;
    user.statistics.points -= item.price;

    return user;
//    final req = PurchaseItemRequest(itemId: itemId);
//    return _userPersistence.purchaseItem(req);
  }
}
