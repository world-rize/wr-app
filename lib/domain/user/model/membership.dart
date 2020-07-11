// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:json_annotation/json_annotation.dart';

enum Membership {
  @JsonValue('normal')
  normal,
  @JsonValue('pro')
  pro,
}
