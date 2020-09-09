// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/toast.dart';

class ShopNotifier with ChangeNotifier {
  UserService _userService;

  /// singleton
  static ShopNotifier _cache;

  factory ShopNotifier({
    @required UserService userService,
  }) {
    return _cache ??= ShopNotifier._internal(userService: userService);
  }

  ShopNotifier._internal({
    @required UserService userService,
  }) : _userService = userService;

  Future<List<GiftItem>> getShopItems() {
    return _userService.getShopItems();
  }

  Future<void> buyShopItem({
    @required String itemId,
  }) async {
    try {
      await _userService.buyShopItem(itemId: itemId);
    } catch (e) {
      InAppLogger.error(e);
      NotifyToast.error(e);
    }
  }
}
