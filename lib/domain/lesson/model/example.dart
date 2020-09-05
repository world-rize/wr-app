// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/message.dart';

part 'example.g.dart';

/// フレーズ例
@JsonSerializable()
class Example {
  Example({@required this.value});

  factory Example.fromJson(Map<dynamic, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  @JsonKey(name: '@type')
  String type;

  /// 会話例
  List<Message> value;
}
