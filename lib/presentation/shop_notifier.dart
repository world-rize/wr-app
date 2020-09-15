// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/usecase/shop_service.dart';

class ShopNotifier with ChangeNotifier {
  final ShopService _shopService;

  /// ユーザーデータ
  User _user;

  /// singleton
  static ShopNotifier _cache;

  factory ShopNotifier({
    @required ShopService shopService,
  }) {
    return _cache ??= ShopNotifier._internal(shopService: shopService);
  }

  ShopNotifier._internal({
    @required ShopService shopService,
  }) : _shopService = shopService;

  Future<List<GiftItem>> getShopItems() {
    return _shopService.getShopItems();
  }

  /// purchase item
  Future<void> purchaseItem({@required String itemId}) async {
    _user = await _shopService.purchaseItem(user: _user, itemId: itemId);
    notifyListeners();
  }
}
