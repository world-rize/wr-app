// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/user_repository.dart';

// TODO: i10n注入
class UserPersistence implements UserRepository {
  const UserPersistence({@required this.store});

  final FirebaseFirestore store;

  CollectionReference get users => store.collection('users');

  Future<User> setUser(User user) async {
    await users.doc(user.uuid).set(user.toJson());
    return user;
  }

  @override
  Future<User> deleteFavoriteList({
    @required User user,
    @required String listId,
  }) async {
    return setUser(user..favorites.remove(listId));
  }

  @override
  Future<User> createFavoriteList({
    @required User user,
    @required String title,
  }) async {
    final list = FavoritePhraseList.create(title: title);
    return setUser(user..favorites[list.id] = list);
  }

  @override
  Future<User> updateFavoriteList({
    @required User user,
    @required FavoritePhraseList list,
  }) async {
    return setUser(user..favorites[list.id] = list);
  }

  @override
  Future deleteUser({
    @required String uuid,
  }) async {
    return users.doc(uuid).delete();
  }

  @override
  Future<User> updateUser({
    @required User user,
  }) {
    return setUser(user);
  }

  @override
  Future<User> createUser({
    @required String name,
    @required String email,
  }) async {
    return User.create()
      ..name = name
      ..attributes.email = email;
  }

  @override
  Future<User> readUser({
    @required String uuid,
  }) async {
    return User.fromJson((await users.doc(uuid).get()).data());
  }
}
