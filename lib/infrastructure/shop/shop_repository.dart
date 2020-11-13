// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_classes/data_classes.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/infrastructure/shop/i_shop_repository.dart';
import 'package:wr_app/util/env_keys.dart';

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
}
