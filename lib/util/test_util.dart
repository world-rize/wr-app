// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wr_app/domain/user/index.dart';

extension StoreEx on FirebaseFirestore {
  CollectionReference get users => collection('users');

  Future<User> getDummyUser() async {
    return User.fromJson((await users.doc('test').get()).data());
  }

  Future<User> setDummyUser(User user) async {
    await users.doc('test').set(user.toJson());
    return user;
  }
}

Future<bool> snapShotDiff<T>({
  @required Future<T> Function() getter,
  @required Future Function() callback,
  @required bool Function(T, T) matcher,
}) async {
  final before = await getter();
  await callback();
  final after = await getter();
  return matcher(before, after);
}
