// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_item.g.dart';

/// 交換できるもの
@JsonSerializable(explicitToJson: true, anyMap: true)
class ShopItem {
  ShopItem({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.expendable,
  });

  /// id
  String id;

  /// ギフト名
  String title;

  /// 説明
  String description;

  /// 価格
  int price;

  /// 複数購入可能か
  bool expendable;

  factory ShopItem.fromJson(Map<dynamic, dynamic> json) =>
      _$ShopItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShopItemToJson(this);
}
