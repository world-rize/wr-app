// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/user/user_repository.dart';

import '../util/test_util.dart';

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
      ..testResults = streakResult;

    await store.setDummyUser(initialUser);
  });

  group('User Repository', () {
    test('readUser', () async {
      final user = await repo.readUser(uuid: 'test');
      final uuid = (await store.getDummyUser()).uuid;
      expect(user.uuid, uuid);
    });

    test('createUser', () async {
      final user = User.create()
        ..name = 'Test'
        ..email = 'a@b.com';
      await repo.createUser(user: user);
      final storeUser = await repo.readUser(uuid: user.uuid);
      expect(storeUser.name, user.name);
      expect(storeUser.email, user.email);
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
            ..email = 'c@d.com';
          await repo.updateUser(user: u);
        },
        matcher: (b, a) => a.email == 'c@d.com',
      );

      expect(diff, true);
    });
  });
}
