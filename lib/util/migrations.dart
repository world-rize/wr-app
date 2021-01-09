// Copyright © 2020 WorldRIZe. All rights reserved.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/note/model/note_v1.dart';
import 'package:wr_app/domain/note/model/note_v2.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/model/shop_item_v1.dart';
import 'package:wr_app/domain/shop/model/shop_item_v2.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/domain/user/model/user_v1.dart';
import 'package:wr_app/domain/user/model/user_v2.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';
import 'package:wr_app/util/logger.dart';

extension FireStoreBatchExtension on WriteBatch {
  void addAll<T>(CollectionReference ref, Iterable<T> list,
      MapEntry<String, Map<String, dynamic>> Function(T) toEntry) {
    for (final data in list) {
      final entry = toEntry(data);
      set(ref.doc(entry.key), entry.value);
    }
  }
}

///
/// /versions/
/// |_ v0/
///   |- users/ (user data User)
///   |- items/ (master data ShopItem)
/// |- v1/
///   |- users/ (user data UserV1)
///   |- items/ (master data ShopItemV1)
/// |- v2
///   |- users/ (user data UserV2)
///   |- items/ (master data ShopItemV2)
class MigrationExecutor {
  MigrationExecutor({@required this.store});

  final FirebaseFirestore store;

  DocumentReference userRef(String version, String uid) {
    return store.version(version).collection('users').doc(uid);
  }

  Future<bool> existUserData(String version, String uid) async {
    return (await userRef(version, uid).get()).exists;
  }

  // v0 -> v1
  Future _migrateUserDataFromV0(String uid) async {
    const from = 'v0';
    const to = 'v1';
    final fromRef = userRef(from, uid);
    final toRef = userRef(to, uid);

    if (await existUserData(to, uid)) {
      return;
    }

    try {
      // get
      final userV0 = User.fromJson((await fromRef.get()).data());
      final notesV0 = (await fromRef.collection('notes').get())
          .docs
          .map((doc) => Note.fromJson(doc.data()));

      // convert
      final userV1 = UserV1.fromUserV0(userV0);
      final notesV1 = notesV0.map((note) => NoteV1.fromNoteV0(note));

      // set
      final batch = store.batch()
        ..set(toRef, userV1.toJson())
        ..addAll<NoteV1>(toRef.collection('notes'), notesV1,
            (note) => MapEntry(note.id, note.toJson()));

      await batch.commit();
    } on Exception catch (e) {
      InAppLogger.info('$from -> $to マイグレーションに失敗しました');
      InAppLogger.error(e);
      rethrow;
    }
  }

  Future _migrateUserDateFromV1(String uid) async {
    const from = 'v1';
    const to = 'v2';
    final fromRef = userRef(from, uid);
    final toRef = userRef(to, uid);

    if (await existUserData(to, uid)) {
      return;
    }

    try {
      await _migrateUserDataFromV0(uid);

      // get
      final userV1 = UserV1.fromJson((await fromRef.get()).data());
      final notesV1 = (await fromRef.collection('notes').get())
          .docs
          .map((doc) => NoteV1.fromJson(doc.data()));

      // convert
      final userV2 = UserV2.fromUserV1(userV1);
      final notesV2 = notesV1.map((note) => NoteV2.fromNoteV1(note));

      // set
      final batch = store.batch()
        ..set(toRef, userV2.toJson())
        ..addAll<NoteV2>(toRef.collection('notes'), notesV2,
            (note) => MapEntry(note.id, note.toJson()));

      await batch.commit();
    } on Exception catch (e) {
      InAppLogger.info('$from -> $to マイグレーションに失敗しました');
      InAppLogger.error(e);
      rethrow;
    }
  }

  Future _migrateMasterDataFromV0() async {
    const from = 'v0';
    const to = 'v1';
    final fromRef = store.version(from);
    final toRef = store.version(to);

    try {
      // get
      final itemsV0 = (await fromRef.collection('items').get())
          .docs
          .map((doc) => ShopItem.fromJson(doc.data()));

      // convert
      final itemsV1 = itemsV0.map((item) => ShopItemV1.fromShopItemV0(item));

      // set
      final batch = store.batch()
        ..addAll<ShopItemV1>(toRef.collection('items'), itemsV1,
            (item) => MapEntry(item.id, item.toJson()));

      await batch.commit();
    } on Exception catch (e) {
      InAppLogger.info('$from -> $to マイグレーションに失敗しました');
      InAppLogger.error(e);
      rethrow;
    }
  }

  Future _migrateMasterDataFromV1() async {
    const from = 'v1';
    const to = 'v2';
    final fromRef = store.version(from);
    final toRef = store.version(to);

    try {
      await _migrateMasterDataFromV0();

      // get
      final itemsV1 = (await fromRef.collection('items').get())
          .docs
          .map((doc) => ShopItemV1.fromJson(doc.data()));

      // convert
      final itemsV2 = itemsV1.map((item) => ShopItemV2.fromShopItemV1(item));

      // set
      final batch = store.batch()
        ..addAll<ShopItemV2>(toRef.collection('items'), itemsV2,
            (item) => MapEntry(item.id, item.toJson()));

      await batch.commit();
    } on Exception catch (e) {
      InAppLogger.info('$from -> $to マイグレーションに失敗しました');
      InAppLogger.error(e);
      rethrow;
    }
  }

  Future migrateUserData(String uid) async {
    // latest model is V2 for test
    await _migrateUserDateFromV1(uid);
  }

  Future migrateMasterData() async {
    // latest model is V2 for test
    await _migrateMasterDataFromV1();
  }
}
