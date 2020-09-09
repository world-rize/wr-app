// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/model/user.dart';

abstract class ShopRepository {
  Future<List<GiftItem>> shopItems();

  Future<User> buyShopItem(String itemId);
}
