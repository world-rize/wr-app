// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';

abstract class UserRepository {
  User generateInitialUser(String uuid);

  FavoritePhraseList generateFavoriteList({
    @required String listId,
    @required String title,
    bool isDefault = false,
  });

  Note generateNote({
    @required String noteId,
    @required String title,
    bool isDefault,
    bool isAchieved,
  });

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

  Future<User> favoritePhrase({
    @required String uuid,
    @required String phraseId,
    @required String listId,
    @required bool favorite,
  });

  Future<User> getPoint({
    @required String uuid,
    @required int points,
  });

  Future<User> doTest({
    @required String uuid,
    @required String sectionId,
  });

  Future<bool> checkTestStreaks({
    @required String uuid,
  });

  Future<User> sendTestResult({
    @required String uuid,
    @required String sectionId,
    @required int score,
  });

  Future<User> createFavoriteList({
    @required String uuid,
    @required String title,
  });

  Future<User> deleteFavoriteList({
    @required String uuid,
    @required String listId,
  });

  Future<User> findUserByUserId({
    @required String uuid,
  });

  Future<void> introduceFriend({
    @required String uuid,
    @required String introduceeUserId,
  });
}
