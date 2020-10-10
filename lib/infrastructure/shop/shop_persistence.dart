// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:wr_app/domain/shop/model/shop_item.dart';
import 'package:wr_app/domain/shop/shop_repository.dart';
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/env_keys.dart';

class ShopPersistence implements ShopRepository {
  @override
  Future<List<GiftItem>> shopItems() async {
    return callFunction('getShopItems').then((res) => List.from(res.data)
        .map((d) => GiftItem.fromJson(Map.from(d)))
        .toList());
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
