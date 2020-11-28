// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/user/index.dart';

abstract class IUserRepository {
  /// なかったらnullを返す
  Future<User> findByUid({
    @required String uid,
  });

  Future<User> readUser({
    @required String uuid,
  });

  Future<User> createUser({
    @required User user,
  });

  Future<User> updateUser({
    @required User user,
  });

  Future<void> deleteUser({
    @required String uuid,
  });
}
