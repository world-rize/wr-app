// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftItem _$GiftItemFromJson(Map json) {
  return GiftItem(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    expendable: json['expendable'] as bool,
  );
}

Map<String, dynamic> _$GiftItemToJson(GiftItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'expendable': instance.expendable,
    };
