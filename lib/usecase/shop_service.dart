// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/shop/i_shop_repository.dart';

class ShopService {
  final IShopRepository _shopRepository;

  const ShopService({
    @required IShopRepository shopRepository,
  }) : _shopRepository = shopRepository;

  /// ショップのアイテムを取得
  Future<List<ShopItem>> getShopItems() {
    return _shopRepository.shopItems();
  }

  Future sendAmazonGiftRequest({@required String uid}) {
    return _shopRepository.sendAmazonGiftEmail(uid);
  }

  Future sendITunesRequest({@required String uid}) {
    return _shopRepository.sendITunesGiftEmail(uid);
  }

  /// アイテムを購入
  Future<User> purchaseItem({
    @required User user,
    @required String itemId,
  }) async {
    final item = (await _shopRepository.shopItems())
        .firstWhere((item) => item.id == itemId, orElse: () => null);

    if (item == null) {
      return user;
    }

    user.items.putIfAbsent(item.id, () => 0);
    user.items[item.id] += 1;
    user.statistics.points -= item.price;
    return user;
  }
}
