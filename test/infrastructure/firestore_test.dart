import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/infrastructure/user/user_repository.dart';

void main() {
  final store = MockFirestoreInstance();
  final repo = UserRepository(store: store);

  const userUuid = 'test';
  setUp(() async {
    final initialUser = User.create()..uuid = userUuid;
    print('setup');

    await store
        .collection('users')
        .doc(initialUser.uuid)
        .set(initialUser.toJson());
  });

  tearDown(() async {
    await store.collection('users').doc(userUuid).delete();
    print('done tear down');
  });

  group('Firestore', () {
    test('Collection in Collection', () async {
      final initialUser = User.create()..uuid = userUuid;
      await store
          .collection('users')
          .doc(initialUser.uuid)
          .set(initialUser.toJson());

      await store
          .collection('users')
          .doc(initialUser.uuid)
          .collection('sub-collection')
          .doc('someid')
          .set({'hoge': 'hoge'});

      // setでは配下のsub-collectionは消えない
      await store
          .collection('users')
          .doc(initialUser.uuid)
          .set(initialUser.toJson());

      print('all sub collection');
      final a = await store
          .collection('users')
          .doc(initialUser.uuid)
          .collection('sub-collection')
          .doc('someid')
          .get();
      print(a.data());

      // sub-collectionはMapに含まれて戻ってこない
      final user = await store.collection('users').doc(initialUser.uuid).get();
      print(user.data().keys.toList());
    });
  });
}
