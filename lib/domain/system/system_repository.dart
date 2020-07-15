// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/util/notification.dart';

abstract class ISystemRepository {
  Future<void> notify(
      {AppNotifier notificator, String title, String body, String payload});
}

class SystemRepository implements ISystemRepository {
  @override
  Future<void> notify(
      {AppNotifier notificator, String title, String body, String payload}) {
    return notificator.showNotification(
        title: title, body: body, payload: payload);
  }
}
