// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class ShopService {
  final ShopRepository _shopPersistence;
  final UserRepository _userPersistence;

  const ShopService({
    required UserRepository userPersistence,
    required ShopRepository shopPersistence,
  })   : _userPersistence = userPersistence,
        _shopPersistence = shopPersistence;

  /// ショップのアイテムを取得
  Future<List<GiftItem>> getShopItems() {
    return _shopPersistence.shopItems();
  }

  Future sendAmazonGiftRequest({required String uid}) {
    return _shopPersistence.sendAmazonGiftEmail(uid);
  }

  Future sendITunesRequest({required String uid}) {
    return _shopPersistence.sendITunesGiftEmail(uid);
  }

  /// アイテムを購入
  Future<User> purchaseItem({
    required User user,
    required String itemId,
  }) async {
    final item = (await _shopPersistence.shopItems())
        .firstWhere((item) => item.id == itemId);

    assert(item != null);
    assert(user != null);

    if (item == null) {
      print('hgoe');
      return user;
    }

    user.items.putIfAbsent(item.id, () => 0);
    user.items[item.id] = user.items[item.id]! + 1;
    user.statistics.points -= item.price;
    await _userPersistence.updateUser(user);

    return user;
  }
}
