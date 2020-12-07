// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tuple/tuple.dart';
import 'package:wr_app/domain/shop/model/receipt.dart';
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
  // TODO: functions?
  Future<User> purchaseItem({
    @required User user,
    @required String itemId,
  }) async {
    final item = (await _shopRepository.shopItems())
        .firstWhere((item) => item.id == itemId, orElse: () => null);

    if (item == null) {
      throw Exception('item not found');
    }

    if (user.points < item.price) {
      throw Exception('not enough money');
    }

    final receipt = Receipt.create(itemId: item.id, count: 1);
    await _shopRepository.createReceipt(user, receipt);
    user.points -= item.price;
    return user;
  }

  Future<List<Receipt>> getAllReceipts(String userUuid) {
    return _shopRepository.getAllReceipts(userUuid);
  }

  /// レシートとitemの性質からUserがそのitemを買うことができるかを調べる
  /// return (itemを何個もかえるか, ポイントが足りているか, すでに買ったことがあるか)
  Future<Tuple3<bool, bool, bool>> purchasable({
    @required User user,
    @required ShopItem shopItem,
  }) async {
    final receipts = await _shopRepository.filterByItemId(
      userUuid: user.uuid,
      itemId: shopItem.id,
    );
    final count = receipts
        .map((e) => e.count)
        .fold(0, (previousValue, element) => previousValue + element);
    final gettable = shopItem.expendable || !shopItem.expendable && count == 0;
    final alreadyPurchased = !shopItem.expendable && count > 0;
    final purchasable = user.points >= shopItem.price;

    return Tuple3(gettable, purchasable, alreadyPurchased);
  }
}
