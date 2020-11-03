// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:json_annotation/json_annotation.dart';

part 'assets.g.dart';

/// Phraseに結びついている素材へのパスを表す
@JsonSerializable()
class Assets {
  Assets({final voice, final img})
      : voice = voice ?? {},
        img = img ?? {};

  factory Assets.empty() => Assets(voice: {}, img: {});

  factory Assets.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsToJson(this);

  /// 音声素材
  /// e.g. "en-us": "voices/social_1_kp_en-us.mp3"
  Map<String, String> voice;

  /// 画像素材
  Map<String, String> img;
}
