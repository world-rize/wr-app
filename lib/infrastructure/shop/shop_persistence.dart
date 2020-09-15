// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/cloud_functions.dart';

class ShopPersistence implements ShopRepository {
  @override
  Future<List<GiftItem>> shopItems() async {
    return callFunction('getShopItems').then((res) => List.from(res.data)
        .map((d) => GiftItem.fromJson(Map.from(d)))
        .toList());
  }

  @override
  Future<User> buyShopItem(String itemId) {
    // TODO: call buy item api
    throw UnimplementedError();
  }
}
