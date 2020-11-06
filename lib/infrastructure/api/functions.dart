// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/material.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/util/cloud_functions.dart';

abstract class IUserAPI {
  Future introduceFriend({
    @required String introduceeUserId,
  });

  Future<User> getPoint({
    @required String uuid,
    @required int points,
  });

  Future<User> findUserByUserId({
    @required String uuid,
  });
}

class UserAPI implements IUserAPI {
  @override
  Future introduceFriend({
    @required String introduceeUserId,
  }) {
    return callFunction('introduceFriend', {
      'introduceeUserId': introduceeUserId,
    });
  }

  @override
  Future<User> getPoint({@required String uuid, @required int points}) {
    return callFunction('getPoint', {
      'points': points,
    }).then((res) => User.fromJson(res.data));
  }

  @override
  Future<User> findUserByUserId({@required String uuid}) async {
    final res = await callFunction('findUserByUserId', {
      'userId': uuid,
    });
    return res.data != null ? User.fromJson(res.data) : null;
  }
}
