// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/user/index.dart';

abstract class IUserRepository {
  Future<User> readUser({
    @required String uuid,
  });

  Future<User> createUser({
    @required String name,
    @required String email,
  });

  Future<User> updateUser({
    @required User user,
  });

  Future<void> deleteUser({
    @required String uuid,
  });

  Future<User> createFavoriteList({
    @required User user,
    @required String title,
  });

  Future<User> updateFavoriteList({
    @required User user,
    @required FavoritePhraseList list,
  });

  Future<User> deleteFavoriteList({
    @required User user,
    @required String listId,
  });
}
