// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:json_annotation/json_annotation.dart';

part 'assets.g.dart';

/// レッスン
@JsonSerializable()
class Assets {
  Assets({this.voice, this.img});

  factory Assets.empty() => Assets(voice: {}, img: {});

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsToJson(this);

  // 音声素材
  Map<String, String> voice;

  // 画像素材
  Map<String, String> img;
}
