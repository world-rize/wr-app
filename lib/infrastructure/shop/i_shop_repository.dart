// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/shop/model/receipt.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/model/user.dart';

abstract class IShopRepository {
  Future<List<ShopItem>> shopItems();

  Future<void> sendAmazonGiftEmail(String uid);

  Future<void> sendITunesGiftEmail(String uid);

  Future<void> createReceipt(User user, Receipt receipt);

  Future<List<Receipt>> getAllReceipts(String uuid);

  Future<List<Receipt>> filterByItemId({
    @required String userUuid,
    @required String itemId,
  });
}
