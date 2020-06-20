// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/model/phrase/assets.dart';

part 'message.g.dart';

/// フレーズ例中の会話一文
/// <https://projects.invisionapp.com/share/SZV8FUJV5TQ#/screens/397469134> 参照
@JsonSerializable()
class Message {
  Message({@required this.text, @required this.assets});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @JsonKey(name: '@type')
  String type = 'Message';

  Map<String, String> text;

  Assets assets;
}
