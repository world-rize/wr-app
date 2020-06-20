// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) {
  return Example(
      value: (json['value'] as List)
          ?.map((e) =>
              e == null ? null : Message.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..type = json['@type'] as String;
}

Map<String, dynamic> _$ExampleToJson(Example instance) =>
    <String, dynamic>{'@type': instance.type, 'value': instance.value};
