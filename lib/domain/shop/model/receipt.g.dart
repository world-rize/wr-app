// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receipt _$ReceiptFromJson(Map json) {
  return Receipt(
    id: json['id'] as String,
    itemId: json['itemId'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'count': instance.count,
    };
