// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/user/index.dart';

extension StoreEx on FirebaseFirestore {
  CollectionReference get users => collection('users');

  Future<User> getUser(String uuid) async {
    return User.fromJson((await users.doc(uuid).get()).data());
  }

  Future<User> setUser(User user) async {
    await users.doc(user.uuid).set(user.toJson());
    return user;
  }
}

Future<bool> snapShotDiff<T>({
  @required Future<T> Function() getter,
  @required Future Function(T) callback,
  @required bool Function(T, T) matcher,
}) async {
  final before = await getter();
  await callback(before);
  final after = await getter();
  return matcher(before, after);
}

void main() {
  final store = MockFirestoreInstance();
  final repo = UserPersistence(store: store);

  setUp(() async {
    print('setup');
    final initialUser = repo.generateInitialUser('test');

    final favList = repo.generateFavoriteList(listId: 'favlist', title: '');
    final note = repo.generateNote(noteId: 'note', title: '');
    final streakResult = List.generate(100, (index) {
      final date = Jiffy().subtract(duration: Duration(days: index ~/ 3));
      return TestResult(sectionId: '', score: 1, date: date.toIso8601String());
    });

    initialUser
      ..notes[note.id] = note
      ..favorites[favList.id] = favList
      ..statistics.testResults = streakResult;

    await store.setUser(initialUser);
  });

  group('User Persistence', () {
    test('readUser', () async {
      final user = await repo.readUser(uuid: 'test');
      final uuid = (await store.getUser('test')).uuid;
      expect(uuid, user.uuid);
    });

    test('createUser', () async {
      final user = await repo.createUser(name: 'Test', email: 'a@b.com');
      expect('Test', user.name);
    });

    test('deleteFavoriteList', () async {
      await repo.deleteFavoriteList(uuid: 'test', listId: 'favlist');
      final user = await store.getUser('test');
      expect(false, user.favorites.containsKey('favlist'));
    });

    test('createFavoriteList', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getUser('test'),
        callback: (_) => repo.createFavoriteList(uuid: 'test', title: ''),
        matcher: (b, a) => b.favorites.length + 1 == a.favorites.length,
      );
      expect(true, diff);
    });

    test('sendTestResult', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getUser('test'),
        callback: (_) =>
            repo.sendTestResult(uuid: 'test', sectionId: 'section', score: 3),
        matcher: (b, a) =>
            b.statistics.testResults.length + 1 ==
            a.statistics.testResults.length,
      );

      expect(true, diff);
    });

    test('checkTestStreaks', () async {
      final streaked = await repo.checkTestStreaks(uuid: 'test');
      expect(true, streaked);
    });

    test('doTest', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getUser('test'),
        callback: (_) => repo.doTest(uuid: 'test', sectionId: ''),
        matcher: (b, a) =>
            b.statistics.testLimitCount - 1 == a.statistics.testLimitCount,
      );

      expect(true, diff);
    });

    test('favoritePhrase', () async {
      final favList = (await store.getUser('test')).getDefaultFavoriteList();
      await repo.favoritePhrase(
          uuid: 'test', phraseId: 'phrase', listId: favList.id, favorite: true);
      final afterFavList =
          (await store.getUser('test')).getDefaultFavoriteList();
      expect(1, afterFavList.phrases.where((d) => d.id == 'phrase').length);
    });

    test('deleteUser', () async {
      await repo.deleteUser(uuid: 'test');
      final ss = await store.users.doc('test').get();
      expect(false, ss.exists);
    });

    test('updateUser', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getUser('test'),
        callback: (user) async {
          user.attributes.email = 'c@d.com';
          await repo.updateUser(user: user);
        },
        matcher: (b, a) => b.attributes.email == 'c@d.com',
      );

      expect(true, diff);
    });
  });
}
