// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/system_repository.dart';
import 'package:wr_app/util/notification.dart';

class SystemService {
  final ISystemRepository _systemRepository;

  const SystemService({
    @required ISystemRepository systemRepository,
  }) : _systemRepository = systemRepository;

  Future<void> notify(
      {AppNotifier notificator, String title, String body, String payload}) {
    return _systemRepository.notify(
        notificator: notificator, title: title, body: body, payload: payload);
  }
}
