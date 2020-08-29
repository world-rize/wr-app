// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/user/index.dart';

class CustomMembershipConverter implements JsonConverter<Membership, String> {
  const CustomMembershipConverter();

  @override
  Membership fromJson(String membership) =>
      membership == 'normal' ? Membership.normal : Membership.pro;

  @override
  String toJson(Membership membership) =>
      membership == Membership.normal ? 'normal' : 'pro';
}
