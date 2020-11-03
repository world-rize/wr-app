// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/model/message.dart';

part 'example.g.dart';

/// Phraseの会話例を表す
/// ## @type Messagesの例
/// ```
/// Are you going out tonight?
/// 今夜遊びに行くの？
/// I’m not sure (tbh). I might see who else is going out.
/// （正直に言うと）わからない。誰が一緒に行くかによるな。
/// Well, don’t take too long to figure it out!
/// 早めに決めてね！
/// ```
@JsonSerializable()
class Example {
  Example({required this.value});

  factory Example.fromJson(Map<String, dynamic> json) =>
      _$ExampleFromJson(json);

  Map<dynamic, dynamic> toJson() => _$ExampleToJson(this);

  /// 会話例のタイプ. 今はMessagesのみ
  @JsonKey(name: '@type')
  String? type;

  /// 会話例
  List<Message> value;
}
