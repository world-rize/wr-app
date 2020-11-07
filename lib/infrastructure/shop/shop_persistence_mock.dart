// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/i_shop_repository.dart';

class ShopPersistenceMock implements ShopRepository {
  // TODO: マスタデータとして管理(Firebaseとかで)
  @override
  Future<List<GiftItem>> shopItems() async {
    return [
      GiftItem(
        id: 'amazon',
        title: 'Amazonカード 500ポイント',
        description: 'Amazonで使えるギフトカード',
        price: 5000,
        expendable: true,
      ),
      GiftItem(
        id: 'itunes',
        title: 'iTunesカード 500ポイント',
        description: 'iTunesで使えるギフトカード',
        price: 5000,
        expendable: true,
      ),
      GiftItem(
        id: 'extra_note',
        title: 'ノート追加',
        description: 'ノートの追加',
        price: 2500,
        expendable: true,
      ),
      GiftItem(
        id: 'accent_us',
        title: 'フレーズアクセント(US)',
        description: 'USアクセント',
        price: 2500,
        expendable: false,
      ),
      GiftItem(
        id: 'accent_uk',
        title: 'フレーズアクセント(UK)',
        description: 'UKアクセント',
        price: 2500,
        expendable: false,
      ),
      GiftItem(
        id: 'accent_in',
        title: 'フレーズアクセント(IN)',
        description: 'INアクセント',
        price: 2500,
        expendable: false,
      ),
    ];
  }

  @override
  Future sendITunesGiftEmail(String uid) async {}

  @override
  Future sendAmazonGiftEmail(String uid) async {}
}
