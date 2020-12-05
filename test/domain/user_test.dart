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
import 'package:wr_app/infrastructure/lesson/favorite_repository.dart';
import 'package:wr_app/infrastructure/note/note_repository.dart';
import 'package:wr_app/infrastructure/user/user_repository.dart';
import 'package:wr_app/usecase/user_service.dart';

import '../util/test_util.dart';

void main() {
  final store = MockFirestoreInstance();
  final auth = MockFirebaseAuth();
  final googleSignIn = MockGoogleSignIn();
  final ur = UserRepository(store: store);
  final ar = AuthRepository(auth: auth, googleSignIn: googleSignIn);
  final fr = FavoriteRepository(store: store);
  final nr = NoteRepository(store: store);
  final service = UserService(
      authRepository: ar,
      userRepository: ur,
      noteRepository: nr,
      userApi: UserAPI(),
      favoriteRepository: fr);

  setUp(() async {
    print('setup');
    final initialUser = User.create()..uuid = 'test';

    final streakResult = List.generate(100, (index) {
      final date = Jiffy().subtract(duration: Duration(days: index ~/ 3));
      return TestResult(sectionId: '', score: 1, date: date.toIso8601String());
    });

    initialUser.testResults = streakResult;

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
        matcher: (b, a) => b.testResults.length + 1 == a.testResults.length,
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
        matcher: (b, a) => b.testLimitCount - 1 == a.testLimitCount,
      );

      expect(true, diff);
    });
  });
}
