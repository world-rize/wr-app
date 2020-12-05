// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:wr_app/domain/shop/model/receipt.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/shop/i_shop_repository.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

class ShopRepository implements IShopRepository {
  const ShopRepository({@required this.store});

  final FirebaseFirestore store;

  @override
  Future<List<ShopItem>> shopItems() async {
    return (await store.collection('shop').get())
        .docs
        .map((doc) => ShopItem.fromJson(doc.data()))
        .toList();
  }

  @override
  Future sendITunesGiftEmail(String uid) {
    final email = GetIt.I<EnvKeys>().giftMailAddress;
    final template = '''
    Amazonギフトカードをください。
    uid: $uid
    ''';
    final request = Email(
      body: template,
      subject: 'WorldRIZe gift request',
      recipients: [email],
      attachmentPaths: [],
      isHTML: false,
    );

    return FlutterEmailSender.send(request);
  }

  @override
  Future sendAmazonGiftEmail(String uid) {
    final email = GetIt.I<EnvKeys>().giftMailAddress;
    final template = '''
    iTunesカードをください。
    uid: $uid
    ''';
    final request = Email(
      body: template,
      subject: 'WorldRIZe gift request',
      recipients: [email],
      attachmentPaths: [],
      isHTML: false,
    );

    return FlutterEmailSender.send(request);
  }

  @override
  Future<void> createReceipt(User user, Receipt receipt) {
    return store.latest
        .collection('users')
        .doc(user.uuid)
        .collection('receipts')
        .doc(receipt.id)
        .set(receipt.toJson());
  }

  @override
  Future<List<Receipt>> getAllReceipts(String uuid) async {
    final l = [];
    await store.latest
        .collection('users')
        .doc(uuid)
        .collection('receipts')
        .get()
        .then((value) async {
      await Future.forEach(
          value.docs,
          (QueryDocumentSnapshot element) =>
              l.add(Receipt.fromJson(element.data())));
    });
    return l;
  }

  @override
  Future<List<Receipt>> filterByItemId({
    @required String userUuid,
    @required String itemId,
  }) async {
    final l = <Receipt>[];
    await store.latest
        .collection('users')
        .doc(userUuid)
        .collection('receipts')
        .where('itemId', isEqualTo: itemId)
        .get()
        .then((value) async {
      await Future.forEach(
          value.docs,
          (QueryDocumentSnapshot element) =>
              l.add(Receipt.fromJson(element.data())));
    });
    return l;
  }
}
