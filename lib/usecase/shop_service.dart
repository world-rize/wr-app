// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';

class ShopService {
  final ShopRepository _shopPersistence;

  const ShopService({
    @required ShopRepository shopPersistence,
  }) : _shopPersistence = shopPersistence;

  /// ショップのアイテムを取得
  Future<List<GiftItem>> getShopItems() {
    return _shopPersistence.shopItems();
  }

  /// アイテムを購入
  Future<User> purchaseItem({
    @required User user,
    @required String itemId,
  }) async {
    final item = (await _shopPersistence.shopItems())
        .firstWhere((item) => item.id == itemId);
    if (item == null) {
      return user;
    }
    user.items.putIfAbsent(item.id, () => 0);
    user.items[item.id] += 1;
    user.statistics.points -= item.price;

    return user;
//    final req = PurchaseItemRequest(itemId: itemId);
//    return _userPersistence.purchaseItem(req);
  }
}
