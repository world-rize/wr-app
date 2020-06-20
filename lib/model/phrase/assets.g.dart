// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assets _$AssetsFromJson(Map<String, dynamic> json) {
  return Assets(
      voice: (json['voice'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      img: (json['img'] as Map<String, dynamic>)?.map(
        (k, e) => MapEntry(k, e as String),
      ));
}

Map<String, dynamic> _$AssetsToJson(Assets instance) =>
    <String, dynamic>{'voice': instance.voice, 'img': instance.img};
