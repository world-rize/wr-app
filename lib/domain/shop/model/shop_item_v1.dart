// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';

part 'shop_item_v1.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ShopItemV1 {
  ShopItemV1({
    @required this.id,
    @required this.titleUpperCase,
  });

  factory ShopItemV1.fromJson(Map<dynamic, dynamic> json) =>
      _$ShopItemV1FromJson(json);

  factory ShopItemV1.fromShopItemV0(ShopItem shopItemV0) {
    return ShopItemV1(
        id: shopItemV0.id, titleUpperCase: shopItemV0.title.toUpperCase());
  }

  Map<String, dynamic> toJson() => _$ShopItemV1ToJson(this);

  String id;

  String titleUpperCase;
}
