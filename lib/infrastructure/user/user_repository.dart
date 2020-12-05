// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/i_user_repository.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

// TODO: i10n注入
class UserRepository implements IUserRepository {
  const UserRepository({@required this.store});

  final FirebaseFirestore store;

  Future<CollectionReference> usersCollection() async {
    return store.latest.collection('users');
  }

  Future<User> setUser(User user) async {
    await (await usersCollection()).doc(user.uuid).set(user.toJson());
    return user;
  }

  @override
  Future<User> findByUid({
    @required String uid,
  }) async {
    final data = await (await usersCollection()).doc(uid).get();
    return data.data() == null ? null : User.fromJson(data.data());
  }

  @override
  Future deleteUser({
    @required String uuid,
  }) async {
    return (await usersCollection()).doc(uuid).delete();
  }

  @override
  Future<User> updateUser({
    @required User user,
  }) {
    return setUser(user);
  }

  @override
  Future<User> createUser({
    @required User user,
  }) async {
    await (await usersCollection()).doc(user.uuid).set(user.toJson());
    return user;
  }

  @override
  Future<User> readUser({
    @required String uuid,
  }) async {
    final data = (await (await usersCollection()).doc(uuid).get()).data();
    return data == null ? null : User.fromJson(data);
  }
}
