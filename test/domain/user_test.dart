// Copyright © 2020 WorldRIZe. All rights reserved.

// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/api/functions.dart';
import 'package:wr_app/infrastructure/auth/auth_repository.dart';
import 'package:wr_app/infrastructure/user/user_repository.dart';
import 'package:wr_app/usecase/user_service.dart';

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
  final auth = MockFirebaseAuth();
  final googleSignIn = MockGoogleSignIn();
  final ur = UserRepository(store: store);
  final ar = AuthRepository(auth: auth, googleSignIn: googleSignIn);
  final service =
      UserService(authRepository: ar, userRepository: ur, userApi: UserAPI());

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

  group('UserService', () {
    test('sendTestResult', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getDummyUser(),
        callback: () async {
          final u = await store.getDummyUser();
          await service.sendTestResult(user: u, sectionId: 'section', score: 3);
        },
        matcher: (b, a) =>
            b.statistics.testResults.length + 1 ==
            a.statistics.testResults.length,
      );

      expect(true, diff);
    });

    test('checkTestStreaks', () async {
      final user = await store.getDummyUser();
      final streaked = await service.checkTestStreaks(user: user);
      expect(true, streaked);
    });

    test('doTest', () async {
      final diff = await snapShotDiff<User>(
        getter: () => store.getDummyUser(),
        callback: () async {
          final u = await store.getDummyUser();
          await service.doTest(user: u, sectionId: '');
        },
        matcher: (b, a) =>
            b.statistics.testLimitCount - 1 == a.statistics.testLimitCount,
      );

      expect(true, diff);
    });

    test('favoritePhrase', () async {
      final user = await store.getDummyUser();
      final favList = user.getDefaultFavoriteList();
      await service.favorite(
          user: user, phraseId: 'phrase', listId: favList.id, favorite: true);
      final afterFavList =
          (await store.getDummyUser()).getDefaultFavoriteList();
      expect(1, afterFavList.phrases.where((d) => d.id == 'phrase').length);
    });
  });
}
