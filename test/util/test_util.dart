import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

extension StoreEx on FirebaseFirestore {
  CollectionReference get users => latest.collection('users');

  Future<User> getDummyUser() async {
    return User.fromJson((await users.doc('test').get()).data());
  }

  Future<User> setDummyUser(User user) async {
    await users.doc('test').set(user.toJson());
    return user;
  }

  Future<T> get<T>(String path, T Function(Map<String, dynamic>) map) async {
    dynamic _ref = collection('versions');
    for (final seg in path.split('/')) {
      if (seg.endsWith('s')) {
        _ref = _ref.collection(seg);
      } else {
        _ref = _ref.doc(seg);
      }
    }

    final DocumentReference ref = _ref;
    return map((await ref.get()).data());
  }

  Future set(String path, Map<String, dynamic> data) async {
    dynamic _ref = collection('versions');
    for (final seg in path.split('/')) {
      if (seg.endsWith('s')) {
        _ref = _ref.collection(seg);
      } else {
        _ref = _ref.doc(seg);
      }
    }

    final DocumentReference ref = _ref;
    return ref.set(data);
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
