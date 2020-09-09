// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/domain/user/index.dart';

class ShopPersistenceMock implements ShopRepository {
  @override
  Future<List<GiftItem>> shopItems() async {
    return [
      GiftItem(
        id: '1',
        title: 'Amazonカード 500ポイント',
        description: 'Amazonで使えるギフトカード',
        price: 5000,
        available: true,
      ),
      GiftItem(
        id: '2',
        title: 'iTunesカード 500ポイント',
        description: 'iTunesで使えるギフトカード',
        price: 5000,
        available: true,
      ),
      GiftItem(
        id: '3',
        title: 'フレーズアクセント(US)',
        description: 'USアクセント',
        price: 3000,
        available: false,
      ),
      GiftItem(
        id: '4',
        title: 'フレーズアクセント(UK)',
        description: 'USアクセント',
        price: 3000,
        available: true,
      ),
      GiftItem(
        id: '5',
        title: 'フレーズアクセント(IN)',
        description: 'INアクセント',
        price: 3000,
        available: true,
      ),
    ];
  }

  @override
  Future<User> buyShopItem(String itemId) {
    // TODO: call buy item api
    throw UnimplementedError();
  }
}
