// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'receipt.g.dart';

/// 交換できるもの
@JsonSerializable(explicitToJson: true, anyMap: true)
class Receipt {
  Receipt({
    @required this.id,
    @required this.itemId,
    @required this.count,
  });

  Receipt.create({
    @required this.itemId,
    @required this.count,
  }) : id = Uuid().v4();

  /// id
  String id;

  /// 買ったアイテムのID
  String itemId;

  /// 何個買ったか
  int count;

  factory Receipt.fromJson(Map<dynamic, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
