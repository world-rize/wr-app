// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/shop/model/shop_item.dart';

abstract class ShopRepository {
  Future<List<GiftItem>> shopItems();

  Future<void> sendAmazonGiftEmail(String uid);

  Future<void> sendITunesGiftEmail(String uid);
}
