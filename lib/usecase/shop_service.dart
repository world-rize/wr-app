// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/infrastructure/shop/i_shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/i_user_repository.dart';

class ShopService {
  final IShopRepository _shopRepository;
  final IUserRepository _userRepository;

  const ShopService({
    @required IUserRepository userRepository,
    @required IShopRepository shopRepository,
  })  : _userRepository = userRepository,
        _shopRepository = shopRepository;

  /// ショップのアイテムを取得
  Future<List<GiftItem>> getShopItems() {
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

    assert(item != null);
    assert(user != null);

    if (item == null) {
      print('hgoe');
      return user;
    }

    user.items.putIfAbsent(item.id, () => 0);
    user.items[item.id] += 1;
    user.statistics.points -= item.price;
    await _userRepository.updateUser(user: user);

    return user;
  }
}
