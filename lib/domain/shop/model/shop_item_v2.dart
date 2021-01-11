// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/shop/model/shop_item_v1.dart';

part 'shop_item_v2.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ShopItemV2 {
  ShopItemV2({
    @required this.id,
    @required this.titleReversed,
  });

  factory ShopItemV2.fromJson(Map<dynamic, dynamic> json) =>
      _$ShopItemV2FromJson(json);

  factory ShopItemV2.fromShopItemV1(ShopItemV1 shopItemV1) {
    final rev =
        String.fromCharCodes(shopItemV1.titleUpperCase.runes.toList().reversed);
    return ShopItemV2(id: shopItemV1.id, titleReversed: rev);
  }

  Map<String, dynamic> toJson() => _$ShopItemV2ToJson(this);

  String id;

  String titleReversed;
}
