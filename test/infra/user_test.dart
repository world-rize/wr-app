// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/user_persistence.dart';

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

void main() {
  final store = MockFirestoreInstance();
  final repo = UserRepository(store: store);

  setUp(() async {
    print('setup');
    final initialUser = User.create()..uuid = 'test';

    final favList = FavoritePhraseList.create(title: '')..id = 'favlist';
    final note = Note.create(title: '')..id = 'note';
    final streakResult = List.generate(100, (index) {
      final date = Jiffy().subtract(duration: Duration(days: index ~/ 3));
      return TestResult(sectionId: '', score: 1, date: date.toIso8601String());
    });

    initialUser
      ..notes[note.id] = note
      ..favorites[favList.id] = favList
      ..statistics.testResults = streakResult;

    await store.setDummyUser(initialUser);
  });

  group('User Repository', () {
    test('readUser', () async {
      final user = await repo.readUser(uuid: 'test');
      final uuid = (await store.getDummyUser()).uuid;
      expect(user.uuid, uuid);
    });

    test('createUser', () async {
      final user = await repo.createUser(name: 'Test', email: 'a@b.com');
      expect(user.name, 'Test');
    });

    test('deleteFavoriteList', () async {
      final beforeUser = await store.getDummyUser();
      await repo.deleteFavoriteList(user: beforeUser, listId: 'favlist');
      final afterUser = await store.getDummyUser();
      expect(afterUser.favorites.containsKey('favlist'), false);
    });

    test('createFavoriteList', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getDummyUser(),
        callback: () async {
          final u = await store.getDummyUser();
          await repo.createFavoriteList(user: u, title: '');
        },
        matcher: (b, a) {
          print(b.favorites.keys);
          print(a.favorites.keys);
          return b.favorites.length + 1 == a.favorites.length;
        },
      );
      expect(diff, true);
    });

    test('deleteUser', () async {
      await repo.deleteUser(uuid: 'test');
      final ss = await store.users.doc('test').get();
      expect(ss.exists, false);
    });

    test('updateUser', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getDummyUser(),
        callback: () async {
          final u = await store.getDummyUser()
            ..attributes.email = 'c@d.com';
          await repo.updateUser(user: u);
        },
        matcher: (b, a) => a.attributes.email == 'c@d.com',
      );

      expect(diff, true);
    });
  });
}
