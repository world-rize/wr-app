// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

enum ArticleType {
  @JsonValue('inApp')
  inApp,

  @JsonValue('external')
  external,
}
